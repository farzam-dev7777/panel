class LawFirmsController < BaseController
    
	def edit
    redirect_to set_new_password_path unless current_user.new_password_set
    @law_firm = LawFirm.find(current_law_firm.id)
    @law_firm_tenant = @law_firm.law_firms_tenants.find_or_create_by(tenant_id: Tenant&.current&.id) 
	end

	def update
		@law_firm = LawFirm.find(current_law_firm.id)
  	if @law_firm.update(law_firms_params)
  		@law_firm.update(profile_completed: true)
      law_firm_tenant = @law_firm.law_firms_tenants.where(tenant_id: Tenant&.current&.id).first

      if law_firm_tenant.document.present?
          law_firm_tenant.update(status: 'On Panel')
      end
      # generate submissions on initial update 
      if current_user.role == 'master_user' && @law_firm.form_submissions.empty?
        @law_firm.update(updated_by_lawfirm: true)
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
    user = User.new(email: params[:email], 
              username: params[:email],
              password: params[:temp_password],
              password_confirmation: params[:temp_password_confirmation],
              role: 'user',
              law_firm_id: current_law_firm.id,
              tenant_id: (Tenant.current&.id || nil),
              first_name: params[:first_name],
              last_name: params[:last_name],
            )
    if user.save

      user.set_google_secret
      # LawFirmMailer.invite_user(user, params[:temp_password], current_law_firm).deliver_now!
      @resource = user
      @resource.send_user_info_with_password
      flash[:notice] = "We've added a new lawyer with username #{user.username}"
    else
      flash[:alert] = user.errors.full_messages.join(", ")
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
    user.first_name = params[:first_name] if params[:first_name].present?
    user.last_name = params[:last_name] if params[:last_name].present?
    if params[:new_password] == params[:new_password_confirmation]
      user.password = params[:new_password] if params[:new_password].present?
      user.password_confirmation = params[:new_password_confirmation] if params[:new_password_confirmation].present?
      user.new_password_set = true if params[:new_password].present? && params[:new_password_confirmation].present?
      if user.save
        sign_in(current_user, :bypass => true)
        flash[:notice] = "User saved successfully"
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

  def agreement
    @law_firm = LawFirm.find_by_id params[:id]
  end

  def additional_document
    @law_firm = LawFirm.find_by_id params[:id]
  end

  def get_external_lawyers
    law_firms = LawFirm.where(id: params[:id].to_s.split(','))
    if law_firms.present?
      lawyers = User.where(law_firm_id: law_firms.ids, role:['user', 'master_user']).map{|s| {id:s.id, name: s.name}}
      render json: {users: lawyers}
    else
      render json: {users: []}
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
      :diverse,
      :value_add_activities,
      :feedback,
      :issues,
      :merger_combination,
      :confidentiality_level_of_matters_that_are_handled,
      law_firms_tenants_attributes:[
        :id, :tenant_id, :bmo_relationship_partner_name,
        :bmo_relationship_partner_email, :bmo_relationship_partner_phone_number,
        :secondary_rm_contact, :secondary_rm_contact_email,
        :billing_contact_name, :billing_contact_email,
        :engagement_number, :relationship_number,
        :information_security_class, :information_security_assessment_outcome,
        :action_plan_findings, :action_plan_status,
        :information_security_contact, :information_security_contact_email, :document,
        type_of_matters_your_law_firm_handles_for_us: []
      ],
      locations_attributes: [
        :id, :address1, :address2, :city, 
        :province, :postal_code, :country, :_destroy
      ], jurisdictions_attributes: [
        :id, :country, :_destroy, 
        city: []
      ],
      users_attributes: [
        :id, :first_name, :last_name, :username
      ],
      practice_area: [],
      type_of_services_your_law_firm_provides_generally: [],
      law_firm_attachments_attributes:[:id, :file, :tenant_id, :_destroy]
    )
  end

end
