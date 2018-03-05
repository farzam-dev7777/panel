class LawFirmsController < BaseController

  load_and_authorize_resource
    
	def edit
		@law_firm = LawFirm.find(params[:id])
	end

	def update
		@law_firm = LawFirm.find(params[:id])
  	if @law_firm.update_attributes(law_firms_params)
  		@law_firm.update_attributes(profile_completed: true)
  		redirect_to root_url
  	else
  		flash[:alert] = "There was an error updating the law firm"
  		render :new
  	end
	end

  def invite_users
    law_firm_user_count = current_law_firm.users.count
    temp_password = SecureRandom.hex(6)
    if !user_exists?
      if(law_firm_user_count < LawFirm::USER_LIMIT)
        user = User.new( email: params[:email], 
                  username: SecureRandom.hex(4), 
                  password: temp_password,
                  role: 'user',
                  law_firm_id: current_law_firm.id)
        if user.save
          LawFirmMailer.invite_user(user, temp_password, current_law_firm).deliver_now!
          flash[:alert] = "We've sent an invite to #{user.email}"
        end
      else
        flash[:alert] = "You're only allowed to add #{LawFirm::USER_LIMIT} users"
      end
    else
      flash[:alert] = "A user with #{user.email} is already registered on the system."
    end
  end

  def user_exists?
    User.find_by(email: params[:email]) ? true : false
  end

  def add_users
  end

  private

  def law_firms_params
    params.require(:law_firm).permit(:name, :description, :email, :phone, :temp_password, :relationship_manager_email, :law_firm_type, :principle_name, :principle_title, :principle_contact_info, :parent_company, :sister_firm, locations_attributes: [:id, :address1, :address2, :city, :province, :postal_code, :country, :_destroy], jurisdictions_attributes: [:id, :country, :_destroy,  city: []], practice_area: [])
  end

end
