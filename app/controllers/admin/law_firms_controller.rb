class Admin::LawFirmsController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Dashboard", :root_path

  def index
    @q = LawFirm.includes(:locations).ransack(params[:q])
    @law_firms = @q.result(distinct: true).where(law_firm_category: "PANEL").order('created_at DESC')
    # @law_firms =  LawFirm.where(law_firm_category: "PANEL")

    @params_string = false;
    if !params[:q].nil?
      @params_string =  params[:q][:name_cont].empty? && params[:q][:locations_country_cont].empty? && params[:q][:panel_status_eq].empty? ? false : true
    end 
    add_breadcrumb "Law Firms", :admin_law_firms_path
  end


  def panel_law_firms
    @q = LawFirm.includes(:locations).ransack(params[:q])
    law_firm_ids = LawFirmsTenant.where(tenant_id: Tenant.current&.id).pluck(:law_firm_id)
    @law_firms = @q.result(distinct: true).where(law_firm_category: "PANEL", id: law_firm_ids).order('created_at DESC')
    # @law_firms =  LawFirm.where(law_firm_category: "PANEL")

    @params_string = false;
    if !params[:q].nil?
      @params_string =  params[:q][:name_cont].empty? && params[:q][:locations_country_cont].empty? && params[:q][:panel_status_eq].empty? ? false : true
    end 
    add_breadcrumb "Law Firms", :admin_law_firms_path
  end


  def panel_non_law_firms
    @q = LawFirm.includes(:locations).ransack(params[:q])
    @law_firms = @q.result(distinct: true).where(law_firm_category: "NON_PANEL").order('created_at DESC')
    # @law_firms =  LawFirm.where(law_firm_category: "PANEL")

    @params_string = false;
    if !params[:q].nil?
      @params_string =  params[:q][:name_cont].empty? && params[:q][:locations_country_cont].empty? && params[:q][:panel_status_eq].empty? ? false : true
    end 
    add_breadcrumb "Law Firms", :admin_law_firms_path
  end




  def show
    @law_firm = LawFirm.find(params[:id])
    @panel_request = PanelRequest.find_by_law_firm_id(@law_firm.id)
    if !@law_firm.user.try(:google_secret)
      @law_firm.user.try(:set_google_secret)
    end
    add_breadcrumb @law_firm.name, :admin_law_firm_path
  end

  def create
    @law_firm = LawFirm.new(law_firms_params)
  	if @law_firm.save
      # Pass true as a 2nd arg if admin wants to send the activity as notification as well
      @law_firm.log_activity('account_created', true, current_user)
      #@law_firm.user.send_reset_password_instructions
      begin
        LawFirmsTenant.create(
          law_firm_id: @law_firm&.id,
          tenant_id: Tenant.current&.id || current_user&.tenant_id
        )
      rescue => e
      end
  		redirect_to :admin_law_firms
  	else
  		flash.now[:alert] = @law_firm.errors.full_messages.join(',')
  		render :new
  	end
  end

  def update
    @law_firm = LawFirm.find(params[:id])
    if @law_firm.update_attributes(law_firms_params)
      @law_firm.user.update_attributes(password: params[:law_firm][:password]) if (params[:law_firm][:password] && !params[:law_firm][:password].blank?  && params[:law_firm][:password].length >= 10)
      flash[:notice] = "Law firm information updated"
      redirect_to admin_law_firm_path(@law_firm)
  	else
  		flash.now[:alert] = "There was an error updating the law firm"
  		render :new
  	end
  end

  def new
  	@law_firm = LawFirm.new

    add_breadcrumb "Create Law Firm", :new_admin_law_firm_path 
  end

  def edit
  	@law_firm = LawFirm.find(params[:id])
    add_breadcrumb "#{@law_firm.name}", :admin_law_firm_path 
  end

  def begin_certification_process
    @law_firm = LawFirm.find(params[:id])
    FormSubmission.generate_initial_submissions(@law_firm, current_user)
    head :ok
  end

  def begin_recertification_process
    @law_firm = LawFirm.find(params[:id])
    last_form_submission = @law_firm.form_submissions.latest

    if last_form_submission.status == 'decertified'
      law_firm_user = User.unscoped.find_by(id: @law_firm.user_id)
      law_firm_user.update_attributes(deactivated_at: nil) if law_firm_user
    end

    # Merge the new form (in case there are new questions)
    new_form_submission = last_form_submission.amoeba_dup
    new_form_submission.status = 'sent'
    new_form_submission.submitted = false
    new_form_submission.submitted_on = nil
    new_form_submission.total_score = nil
    new_form_submission.assessor_score = nil
    new_form_submission.expiry_date = nil

    Form.where(step: 'conflicts').last.form_fields.each do |form_field|
      next if new_form_submission.form.try(:form_fields).map(&:label).include? form_field.label
      ff = form_field.amoeba_dup
      ff.formable_id = new_form_submission.form.id
      ff.save
    end

    Form.where(step: 'pricing').last.form_fields.each do |form_field|
      next if new_form_submission.form.try(:form_fields).map(&:label).include? form_field.label
      ff = form_field.amoeba_dup
      ff.formable_id = new_form_submission.form.id
      ff.save
    end

    Form.where(step: 'relationship').last.form_fields.each do |form_field|
      next if new_form_submission.form_relationship.try(:form_fields).map(&:label).include? form_field.label
      ff = form_field.amoeba_dup
      ff.formable_id = new_form_submission.form.id
      ff.save
    end

    Form.where(step: 'diversity').last.form_fields.each do |form_field|
      next if new_form_submission.form_diversity.try(:form_fields).map(&:label).include? form_field.label
      ff = form_field.amoeba_dup
      ff.formable_id = new_form_submission.form.id
      ff.save
    end

    Form.where(step: 'innovation').last.form_fields.each do |form_field|
      next if new_form_submission.form_innovation.try(:form_fields).map(&:label).include? form_field.label
      ff = form_field.amoeba_dup
      ff.formable_id = new_form_submission.form.id
      ff.save
    end

    Form.where(step: 'resourcing').last.form_fields.each do |form_field|
      next if new_form_submission.form_resourcing.try(:form_fields).map(&:label).include? form_field.label
      ff = form_field.amoeba_dup
      ff.formable_id = new_form_submission.form.id
      ff.save
    end

    Form.where(step: 'lawfirm').last.form_fields.each do |form_field|
      next if new_form_submission.form_lawfirm.try(:form_fields).map(&:label).include? form_field.label
      ff = form_field.amoeba_dup
      ff.formable_id = new_form_submission.form.id
      ff.save
    end

     

    if new_form_submission.save
      last_form_submission.update_attributes(expiry_date: nil)
      @law_firm.log_activity('recertification_process_initiated', true, current_user)
      # redirect_to :admin_law_firms
    end
    head :ok
  end

  def decertify
    @law_firm = LawFirm.find_by(id: params[:id])
    @law_firm.user.update_attributes(deactivated_at: Time.now)

    form_submission = @law_firm.form_submissions.latest
    form_submission.status = 'decertified'
    form_submission.reason = params[:reason]

    if form_submission.save!
      LawFirmMailer.firm_decertified(@law_firm).deliver_now
      @law_firm.log_activity('decertified', true, current_user)
      head :ok
    end
  end

  def add_internal_note
    @law_firm = LawFirm.find_by(id: params[:id])
    internal_note = @law_firm.add_internal_note(params[:message], current_user)
    render partial: 'internal_note', locals: {note: internal_note}
  end

  def remove_internal_note
    @law_firm = LawFirm.find_by(id: params[:id])
    internal_note = @law_firm.internal_notes.find_by(id: params[:internal_note_id])
    internal_note.destroy if internal_note
    head :ok
  end

  def law_firms
    case params[:filter]
    when 'certified'
      LawFirm.certified
    when 'under_process'
      LawFirm.in_process
    when 'decertified'
      LawFirm.decertified
    when 'onboarded'
      LawFirm.onboarded
    else
      LawFirm
    end
  end

  def get_detail
    @law_firm = LawFirm.find(params[:id])
    render json: { data: @law_firm }
  end

  def add_by_submission
   
    @law_firm = LawFirm.new
    respond_to do |format|
      format.js
    end
  end

  def get_sub_matter_types
    if params[:id]
      render json: { data: SubMatterType.where(matter_type_id: params[:id]) }
    else
      render json: { data: [] }
    end
  end

  def get_state
    if params[:id]
      @countries = Country.select("country_id").where(id: params[:id])
      render json: { data: State.where(country_id: @countries) }
    else
      render json: { data: [] }
    end
  end

  def get_law_firm_list
    if params[:matter_type].present? ||  params[:sub_matter_type].present? || params[:jurisdiction_type].present? || params[:country].present? || params[:state].present?
      law_firm_ids = LawFirmsTenant.where(tenant_id: Tenant.current&.id)&.pluck(:law_firm_id)
      render json: { data: LawFirm.where(id: law_firm_ids) }
    else
      render json: { data: [] }
    end
  end

  private

  def law_firms_params
  	params.require(:law_firm).permit(
      :name, :description, :email, :phone, :temp_password,
      :temp_password_confirmation, :relationship_manager_email,
      :relationship_manager_name, :relationship_manager_phone,
      :law_firm_type, :principle_name, :principle_title,
      :principle_contact_info, :parent_company, :sister_firm,
      :initial_date_of_engagement_with_the_bank,
      :secondary_rm_contact,
      :secondary_rm_contact_email,
      :billing_contact_name,
      :billing_contact_email,
      :information_security_contact,
      :information_security_contact_email,
      :diverse,
      :merger_combination,
      :engagement_number,
      :relationship_number,
      :information_security_class,
      :information_security_assessment_outcome,
      :action_plan_findings,
      :action_plan_status,
      :confidentiality_level_of_matters_that_are_handled,
      :number_of_lawyers, :law_firm_category, 
      :bmo_relationship_partner_email,
      :bmo_relationship_partner_name,
      :bmo_relationship_partner_phone_number,
      locations_attributes: [
        :id, :address1, :address2,
        :city, :province, :postal_code,
        :country, :_destroy
      ], feedbacks_attributes: [
        :id, :feedback, :_destroy
      ], values_attributes: [
        :id, :value, :_destroy
      ], issues_attributes: [
        :id, :issue, :_destroy
      ], jurisdictions_attributes: [
        :id, :country, :_destroy, city: []
      ], users_attributes: [
        :id, :password,
        :password_confirmation, :_destroy
      ],
      practice_area: [],
      matter_type_ids:[], sub_matter_type_ids: [], jurisdiction_type_ids: [], state_ids: [], country_ids: [],
      type_of_matters_your_law_firm_handles_for_us: [],
      type_of_services_your_law_firm_provides_generally: [],
      confidentiality_level_of_matters_that_are_handled: []
    )
  end

end
