class LawFirmsController < BaseController
    
	def edit
		@law_firm = LawFirm.find(params[:id])
	end

	def update
		@law_firm = LawFirm.find(params[:id])
  	if @law_firm.update_attributes(law_firms_params)
  		@law_firm.update_attributes(profile_completed: true)

      # generate submissions on initial update 
      if current_user.role == 'master_user' && @law_firm.form_submissions.empty?
        @law_firm.update_attributes(updated_by_lawfirm: true)
        FormSubmission.generate_initial_submissions(@law_firm, current_user)
      end

  		redirect_to root_url
  	else
  		flash[:alert] = "There was an error updating the law firm"
  		render :new
  	end
	end

  def invite_users
    redirect_to root_path unless current_user.role == 'master_user'
    law_firm_user_count = current_law_firm.standard_users.count
    temp_password = SecureRandom.hex(6)
    username = SecureRandom.hex(4)
    if(law_firm_user_count < current_law_firm.law_firm_user_limit)
      user = User.new(email: "#{username}#{LawFirm::EMAIL_PREFIX}", 
                username: username,
                password: temp_password,
                role: 'user',
                law_firm_id: current_law_firm.id)
      if user.save
        user.set_google_secret
        # LawFirmMailer.invite_user(user, temp_password, current_law_firm).deliver_now!
        flash[:alert] = "We've added a new user with username #{user.username}"
      end
    else
      flash[:alert] = "You're only allowed to add #{current_law_firm.law_firm_user_limit} users"
    end
    redirect_to add_users_law_firms_path
  end

  def user_exists?
    User.find_by(email: params[:email]) ? true : false
  end

  def add_users
    redirect_to root_path unless current_user.role == 'master_user'
  end

  def set_new_password
    render layout: false
  end

  def update_new_password
    redirect_to root_path if current_user.new_password_set
    law_firm = current_user.law_firm
    if params[:id]
      user = User.find_by(id: params[:id])
    else
      user = current_user
    end

    if params[:new_password] == params[:new_password_confirmation]
      if user.update_attributes(password: params[:new_password], new_password_set: true)
        sign_in(current_user, :bypass => true)
        flash[:notice] = "Password changed successfully"
      else
        flash[:notice] = user.errors.full_messages.join(',')
      end

      # if !current_user.is_a_master_user?
        user.update_attributes(new_password_set: true)
      # end

    else
      flash[:notice] = "Both passwords should match"
    end

    if user.errors.messages.any?
      redirect_to request.referrer
    elsif request.referrer.include?('add_users')
      redirect_to add_users_law_firms_path
    else
      if current_user.role == 'master_user' && !law_firm.updated_by_lawfirm
        redirect_to edit_law_firm_path(current_law_firm)
      else
        redirect_to root_path
      end
    end
  end

  def delete_user
    if (current_user && 
        current_user.is_a_master_user? && 
        current_law_firm.users.map(&:id).include?(params[:id].to_i)
       )
      user = User.find_by(id: params[:id])
      user.destroy!
      redirect_to add_users_law_firms_path
    else
      flash[:error] = "You're not authorized to remove this user"
    end
  end

  private

  def law_firms_params
    params.require(:law_firm).permit(:name, :description, :email, :phone, :temp_password, :relationship_manager_email, :law_firm_type, :principle_name, :principle_title, :principle_contact_info, :parent_company, :sister_firm, locations_attributes: [:id, :address1, :address2, :city, :province, :postal_code, :country, :_destroy], jurisdictions_attributes: [:id, :country, :_destroy,  city: []], practice_area: [])
  end

end
