class MatterIntakesController < BaseController

  def index
    @query = params[:q]||{}
    @invoice_status = @query['invoices_status_cont']
    if @query.present? && @query['invoices_status_cont']&.strip =='pending'
      @query['invoices_status_null']= true
      @query.delete('invoices_status_cont')
    end
    @q = current_user.law_firm.matter_intakes.not_rfp.ransack(@query)
    @matter_intakes = @q.result(distinct: true).order('updated_at DESC')
    add_breadcrumb "Matter Intakes", :admin_matter_intakes_path
  end

  def new
    if current_user&.law_firm&.current_law_firm_tenant&.allow_to_create_matters.present? && current_user&.law_firm.status_show != 'Off Panel'
      @form_type = 'general'
      @matter_intake = MatterIntake.new(form_type: 'general')
      @invoices = @matter_intake.invoices.build
      @invoice_attachments = @invoices.invoice_attachments.build
      @new_form = true
      @current_user = current_user
    else
      redirect_to root_url, alert: 'Access Denied'
    end
  end

  def edit
    @matter_intake = MatterIntake.includes(:invoices).find_by(id: params[:id])
    @new_form = false
    @current_user = current_user
  end

  def show
    @matter_intake = MatterIntake.includes(:invoices).find_by(id: params[:id])
    @matter_approval = @matter_intake.current_user_pending_approval(current_user)
  end

  def review
    @matter_intake = MatterIntake.includes(:invoices).find_by(id: params[:id])
    @new_form = false
    @current_user = current_user
  end

  def lxp_review
    @matter_intake = MatterIntake.includes(:invoices).find_by(id: params[:id])
    @matter_approval = @matter_intake.current_user_pending_approval(current_user)
    @new_form = false
  end

  def create
    @matter_intake = MatterIntake.new(matter_intake_params)
    @matter_intake.law_firm_id = current_user.law_firm&.id if @matter_intake.law_firm_id.blank?
    @matter_intake.requested_by_id = current_user&.id if @matter_intake.requested_by_id.blank?
    @matter_intake.submitter_name = current_user.full_name if @matter_intake.submitter_name.blank?
    @matter_intake.matter_number = "MT-#{Date.today.month}-#{Date.today.day}-#{MatterIntake.count}" if @matter_intake.matter_number.blank?
    if @matter_intake.valid?
      if params[:commit] == "Next" || params[:commit] == "back"
        flash[:alert]=''
        @show_information_security_form = params[:commit] == "Next"
        render :new
      else
        @matter_intake.save
        @matter_intake.update(status: "submitted", lawyer_reviewed_at: Time.now)
        @matter_intake.auto_approve_matter(current_user)
        @matter_intake.set_default_approval_status(current_user)
        @matter_intake.send_notification_to_lawyer
        flash[:notice] = "Matter Intake Form submitted"
        redirect_to @matter_intake
      end
    else
      flash[:alert] = "There was an error initiating matter intake request. #{@matter_intake.errors.full_messages.join(', ')}" 
      render :new
    end
  end

  def information_security_classification
    @matter_intake = MatterIntake.includes(:invoices).find_by(id: params[:matter_intake_id])
  end

  def update

    @matter_intake = MatterIntake.find_by(id: params[:id])
    if @matter_intake.present? && @matter_intake.update(matter_intake_params)
      @matter_intake.auto_approve_matter(current_user)
      @matter_intake.set_default_approval_status(current_user)
      if current_user.role === "internal_lawyers"
        if params[:matter_intake] && params[:matter_intake][:submit_type] && params[:matter_intake][:submit_type] === "update"
          redirect_to matter_intakes_information_security_classification_matter_intakes_path(@matter_intake)
        else
          # @matter_intake.update_attributes(lawyer_reviewed_at: Time.now, status: 'awaiting_lxp_review')
          # @matter_intake.send_notification_to_lxp
          # @matter_intake.send_notification_litigation_specialist_team
          # @matter_intake.add_log_for_lawyer_submission_to_lxp(current_user)
          flash[:notice] = "Matter intake request updated"
          redirect_to matter_intakes_path
        end
       
      elsif current_user.role === "lxp" && @matter_intake.status.present?
        # @matter_intake.update_attributes(lxp_reviewed_at: Time.now, status: @matter_intake.status.downcase, lxp_id: current_user.id)
        # @matter_intake.add_log_matter_open_by_lxp(current_user)
        # @matter_intake.send_notification_to_lawyer_and_lxp
        flash[:notice] = "Matter intake request updated"
        redirect_to matter_intakes_path
      else
        flash[:notice] = "Matter intake request updated"
        redirect_to matter_intakes_path
      end
    else
      flash[:alert] = "There was an error updating matter intake request. #{@matter_intake.errors.full_messages.join(', ')}"
      # @matter_intake = MatterIntake.find_by(id: params[:id])
      @current_lxp_user = current_user
      render :edit,  id: @matter_intake.id
    end
  end

  def lxp_rejects
    @matter_intake = MatterIntake.includes(:invoices).find_by(id: params[:id])
    if current_user.role === "lxp"
      if @matter_intake.update(lxp_reviewed_at: Time.now, status: 'awaiting_lawyer_update', lxp_id: current_user.id)
        #@matter_intake.add_log_for_lxp_rejects_and_returns_to_lawyer(current_user)
        @matter_intake.send_notification_to_lawyer_form_needs_updation
        render json: {
          message: "Successfully rejects matter intake form."
        }
      else 
        render json: {
          errors: "Failed to rejects matter intake form."
        }, status: 404
      end
    end

  end

  def verify_doc
    veryfi_client = Veryfi::Client.new(
      client_id: Rails.application.secrets['veryfi']['client_id'],
      client_secret: Rails.application.secrets['veryfi']['client_secret'],
      username: Rails.application.secrets['veryfi']['username'],
      api_key: Rails.application.secrets['veryfi']['api_key']
    )
    ## write to temp file
    paramss = {
      file_path: params['inovie']['file'].tempfile.path,
      auto_delete: true,
      boost_mode: false,
      async: false,
      max_pages_to_process: 10
    }
    response = veryfi_client.document.process(paramss)
    puts response
    render json: {
      resource: response
    }
  end

  def add_review
    matter_intake = MatterIntake.find_by_id params[:id]
    matter_intake.reviews.create(status: 'comment', description: params[:discription], actor_id: current_user.id)
    redirect_to matter_intake_path(matter_intake), notice: 'Your comment has been added.'
  end

  private
  def matter_intake_params
    params.require(:matter_intake).permit(
      :user_id, :submitter_name, :lob_contact_name, :name_of_matter_client, :matter_type_id, :asset,
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
      :branch, :outside_counsel_engaged, :deal_code, :email_notification_to_litigation_specialist_team, :line_of_business_id,
      :requested_by_id, :related_matter_number, :pii_involved, :internal_file_number, :business_department, :business_group, :matter_number,
      :receive_personal_information, :receive_general_business_data, :applicable_technical_specialty_data,
      applicable_technical_specialty_data_type: [], receive_personal_information_data_type: [], receive_general_business_data_type: [], external_lawyer_ids: [],
      invoices_attributes: [:id, :date, :taxes, :matter_intake_id, :lawyer_name, :rate_type, :description, :hours, :amount, :date, :taxes, :_destroy, invoice_attachments_attributes: [:id, :file, :veryfi_response]],
      matter_intake_attachments_attributes: [:id, :doc_type, :file, :_destroy]
    )
  end

end