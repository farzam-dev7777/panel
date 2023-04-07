class LawFirmsController < BaseController
    
	def edit
    redirect_to set_new_password_path unless current_user.new_password_set
    @law_firm = LawFirm.find(current_law_firm.id)

	end

	def update
		@law_firm = LawFirm.find(current_law_firm.id)
  	if @law_firm.update_attributes(law_firms_params)
  		@law_firm.update_attributes(profile_completed: true)

      # generate submissions on initial update 
      if current_user.role == 'master_user' && @law_firm.form_submissions.empty?
        @law_firm.update_attributes(updated_by_lawfirm: true)
        FormSubmission.generate_initial_submissions(@law_firm, current_user)
      end

  		redirect_to root_url, notice: "Profile updated"
  	else
  		flash.now[:alert] = "There was an error updating the law firm"
  		render :new
  	end
	end

  def invite_users
    redirect_to root_path unless current_user.role == 'master_user'
    law_firm_user_count = current_law_firm.standard_users.count
    username = params[:email]
    if(law_firm_user_count < current_law_firm.law_firm_user_limit)
      user = User.new(email: params[:email], 
                username: params[:email],
                password: params[:temp_password],
                password_confirmation: params[:temp_password_confirmation],
                role: 'user',
                law_firm_id: current_law_firm.id
                tenant_id: Tenant.current&.id || nil
              )
      if user.save
        user.set_google_secret
        # LawFirmMailer.invite_user(user, temp_password, current_law_firm).deliver_now!
        flash[:notice] = "We've added a new user with username #{user.username}"
      else
        flash[:alert] = user.errors.full_messages.join(", ")
      end
    else
      flash[:alert] = "You're only allowed to add #{current_law_firm.law_firm_user_limit} user"
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
    law_firm = current_user.law_firm
    if params[:id]
      user = User.find_by(id: params[:id])
    else
      user = current_user
    end

    if params[:new_password] == params[:new_password_confirmation]
      if user.update_attributes(password: params[:new_password], password_confirmation: params[:new_password_confirmation], new_password_set: true)
        sign_in(current_user, :bypass => true)
        flash[:notice] = "Password changed successfully"
      else
        flash[:alert] = user.errors.full_messages.join(',')
      end
    else
      flash[:alert] = "Both passwords should match"
      redirect_to request.referrer and return true
    end

    if user.errors.messages.any?
      redirect_to request.referrer, alert: user.errors.full_messages.join(', ')
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
      flash.now[:error] = "You're not authorized to remove this user"
    end
  end

  private

  def law_firms_params
    params.require(:law_firm).permit(
      :name, :description, :email, :phone, :temp_password, 
      :relationship_manager_email, :law_firm_type, :principle_name,
      :principle_title, :principle_contact_info, :parent_company,
      :sister_firm, 
      :initial_date_of_engagement_with_the_bank,
      :number_of_lawyers,
      :secondary_rm_contact,
      :secondary_rm_contact_email,
      :billing_contact_name,
      :billing_contact_email,
      :information_security_contact,
      :information_security_contact_email,
      :diverse,
      :value_add_activities,
      :feedback,
      :issues,
      :merger_combination,
      :engagement_number,
      :relationship_number,
      :information_security_class,
      :information_security_assessment_outcome,
      :action_plan_findings,
      :action_plan_status,
      :bmo_relationship_partner_email,
      :bmo_relationship_partner_name,
      :bmo_relationship_partner_phone_number,
      :confidentiality_level_of_matters_that_are_handled,
      locations_attributes: [
        :id, :address1, :address2, :city, 
        :province, :postal_code, :country, :_destroy
      ], jurisdictions_attributes: [
        :id, :country, :_destroy, 
        city: []
      ], 
      practice_area: [], 
      type_of_matters_your_law_firm_handles_for_us: [],
      type_of_services_your_law_firm_provides_generally: []
    )
  end

end
