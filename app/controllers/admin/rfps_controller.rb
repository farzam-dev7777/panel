class Admin::RfpsController< Admin::BaseController
  layout 'admin'

  add_breadcrumb "Admin", :admin_root_path
  before_action :check_tenant_rfp

  def index
    @rfps = Rfp.all
  end

  def show
    @rfp = Rfp.find_by_id params[:id]
    @matter_intake = @rfp.matter_intake
  end

  def edit
    @rfp = Rfp.find_by_id params[:id]
    @matter_intake = @rfp.matter_intake
  end

  def new
    @rfp = Rfp.new
    @rfp.matter_intake = MatterIntake.new
    @matter_intake = @rfp.matter_intake
    Tenant&.current.tenant_questions.each do |tq|
      @rfp.questions << Question.new(message: tq.title, kind: tq.kind)
    end
  end

  def create
    rfp_param_obj = rfp_params
    rfp_param_obj[:questions_attributes].each do |k,v|
      d = v
      d['message'] = v['message'].last
      rfp_param_obj[:questions_attributes][k]= d
    end
    @rfp = Rfp.new(rfp_param_obj)
    @rfp.matter_intake.submitter_name = current_user.full_name
    @rfp.matter_intake.matter_number = "MT-#{Date.today.month}-#{Date.today.day}-#{MatterIntake.count}"
    @rfp.matter_intake.user_id = current_user.id
    if params[:commit] == 'Save Draft'
      @rfp.status = 'draft'
    elsif params[:commit] == 'Save and Notify to Internal Stakeholders'
      @rfp.status = 'only_notify'
    else
      @rfp.status = 'pending'
    end
    @rfp.matter_intake.status = 'pending'
    if @rfp.valid? && @rfp.matter_intake.valid?
      @rfp.save
      (params[:rfp][:invites]||[]).each do |law_firm_id|
        if law_firm_id.present?
          obj = @rfp.rfp_invites.find_or_create_by(law_firm_id: law_firm_id)
          law_firm = LawFirm.find_by_id(law_firm_id)
          obj.user_id = law_firm.user&.id if obj.user_id.blank?
          obj.status = 'pending' if obj.status.blank?
          obj.save
        end
      end
      if @rfp.matter_intake.lawyer_email.present?
        @rfp.matter_intake.create_lawyer()
      end
      flash[:notice] = "RFP Form submitted"
      redirect_to admin_rfps_path()
    else
      @matter_intake = @rfp.matter_intake
      flash[:alert] = "There was an error initiating rfp request. #{[@rfp.errors.full_messages+@rfp.matter_intake.errors.full_messages].join(', ')}" 
      render :new
    end
  end

  def update
    @rfp = Rfp.find_by_id(params[:id])
    rfp_param_obj = rfp_params
    rfp_param_obj[:questions_attributes].each do |k,v|
      d = v
      d['message'] = v['message'].last
      rfp_param_obj[:questions_attributes][k]= d
    end

    if params[:commit] == 'Save Draft'
      rfp_param_obj[:status] = 'draft'
    elsif params[:commit] == 'Save and Notify to Internal Stakeholders'
      rfp_param_obj[:status] = 'only_notify'
    else
      rfp_param_obj[:status] = 'pending'
    end
    @rfp.assign_attributes(rfp_param_obj)
    if @rfp.valid? && @rfp.matter_intake.valid?
      @rfp.save
      (params[:rfp][:invites]||[]).each do |law_firm_id|
        if law_firm_id.present?
          obj = @rfp.rfp_invites.find_or_create_by(law_firm_id: law_firm_id)
          law_firm = LawFirm.find_by_id(law_firm_id)
          obj.user_id = law_firm.user&.id if obj.user_id.blank?
          obj.status = 'pending' if obj.status.blank?
          obj.save
        end
      end
      if @rfp.matter_intake.lawyer_email.present?
        @rfp.matter_intake.create_lawyer()
      end
      flash[:notice] = "RFP Form submitted"
      redirect_to admin_rfps_path()
    else
      @matter_intake = @rfp.matter_intake
      flash[:alert] = "There was an error initiating rfp request. #{[@rfp.errors.full_messages+@rfp.matter_intake.errors.full_messages].join(', ')}" 
      render :edit
    end
  end

  def proposal
    @rfp = Rfp.find_by_id params[:id]
  end

  def check_tenant_rfp
    if Tenant.current&.rfp_enable.blank?
      redirect_back fallback_location: admin_root_path, alert: "RFP is not enabled"
    end
  end

  def rfp_params
    params.require(:rfp).permit(
      :id, :user_id, :expiry_date, :status, :invites,
      questions_attributes: [:id, :kind, :_destroy, message: []],
      rfp_lobs_attributes: [:id, :user_id, :role, :notify, :_destroy],
      matter_intake_attributes: [
        :id, :user_id, :submitter_name, :lob_contact_name, :name_of_matter_client, :matter_type_id, :asset,
        :matter_description, :mode_of_payment, :law_firm_id, :bmo_lawyer_name, :lawyer_id, :budget_amount,
        :lob_id, :lob_contact_for_po, :cost_centre_for_legal_fees, :paying_entity, :business_paying_for_matter,
        :group_paying_for_matter, :status, :lob_submitted_at, :legal_group_of_bmo_lawyer, :work_area, :work_area_type, :is_ore_reportable,
        :is_otherwise_reportable, :is_syndicate_matter, :is_conceal_imanage_workspace, :is_paper_file,
        :jurisdiction, :firm_type, :name_of_panel_firm, :name_of_non_panel_firm, :type_of_price, :who_requires_access_to_imanage_workspace,
        :is_alternative_fee_arrangement, :afa_details, :additional_matter_contact, :other_matter_issues,
        :lawyer_reviewed_at, :other_party, :matter_number, :form_type, :key_facts, :legal_analysis, :stage_of_litigation,
        :allegation_of_employee_misconduct, :primary_issue, :secondary_issue, :bmo_party, :opposing_counsel_firm,
        :written_legal_notice_required, :arbitration_offered, :arbitration_accepted, :branch_manager_investment_advisor,
        :region_name, :date_suit_filed, :unquantified_claim, :valued_at, :amount_claimed_from_bmo_1, :amount_claimed_1_currency,
        :amount_claimed_from_bmo_2, :amount_claimed_2_currency, :amount_claimed_by_bmo, :amount_claimed_by_bmo_currency,
        :breakdown_of_claim_amount, :court_name, :case_caption, :court_type, :docket_number, :comset_issues, :comset_ref,
        :mi_matter, :nature_of_events, :process_type_level_1, :process_type_level_2, :product_type_level_1, :product_type_level_2,
        :event_type_level_1, :event_type_level_2, :business_activity_level_1, :business_activity_level_2, :can_reimbursed_matter,
        :branch, :outside_counsel_engaged, :deal_code, :email_notification_to_litigation_specialist_team,
        :requested_by_id, :related_matter_number, :pii_involved, :internal_file_number, :business_department, :business_group, :matter_number,
        :receive_personal_information, :receive_general_business_data, :applicable_technical_specialty_data, :line_of_business_id,
        :lawyer_first_name, :lawyer_last_name, :lawyer_email, external_lawyer_ids: [], lawyer_ids: [],
        applicable_technical_specialty_data_type: [], receive_personal_information_data_type: [], receive_general_business_data_type: [],
        matter_intake_attachments_attributes: [:id, :doc_type, :file, :_destroy]
      ]
    )
  end

end
