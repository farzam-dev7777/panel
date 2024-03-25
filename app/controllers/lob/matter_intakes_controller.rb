class Lob::MatterIntakesController < Lob::BaseController

  layout 'lob'

  add_breadcrumb "Dashboard", :root_path

  def index
    @query = params[:q]||{}
    @invoice_status = @query['invoices_status_cont']
    if @query.present? && @query['invoices_status_cont']&.strip =='pending'
      @query['invoices_status_null']= true
      @query.delete('invoices_status_cont')
    end
    
    if params[:filter] === "yes"
      @q = MatterIntake.not_rfp.where(status: ["opened"]).where("line_of_business_id in (?) OR user_id = ?", current_user.line_of_businesses.pluck(:id), current_user.id).ransack(@query)
      @matter_intakes = @q.result(distinct: true).order('updated_at DESC')    
    else
      @q = MatterIntake.not_rfp.where("line_of_business_id in (?) OR user_id = ?", current_user.line_of_businesses.pluck(:id), current_user.id).ransack(@query)
      @matter_intakes = @q.result(distinct: true).order('updated_at DESC')
    end
    
    add_breadcrumb "Matter intake", :lob_matter_intakes_path
  end

  def new
    @matter_intake = MatterIntake.new
    @invoices = @matter_intake.invoices.build
    @invoice_attachments = @invoices.invoice_attachments.build
    @current_lob_user = current_lob_user
    @new_form = true
  end

  def edit
    @matter_intake = MatterIntake.includes(:invoices).find_by(id: params[:id])
    @current_lob_user = current_lob_user
    @new_form = false
    
    add_breadcrumb "#{@matter_intake.submitter_name}", :lob_matter_intake_path 
    
  end

  def create
    @matter_intake = MatterIntake.new(matter_intake_params)
    if @matter_intake.law_firm_id.blank?
      @matter_intake.name_of_panel_firm = @matter_intake.law_firm&.name
      @matter_intake.law_firm_id = current_user.law_firm&.id
    end
    @matter_intake.line_of_business_id = current_user.line_of_businesses&.first&.id if @matter_intake.line_of_business_id.blank?
    @matter_intake.requested_by_id = current_user&.id if @matter_intake.requested_by_id.blank?
    @matter_intake.submitter_name = current_user.full_name if @matter_intake.submitter_name.blank?
    @matter_intake.matter_number = "MT-#{Date.today.month}-#{Date.today.day}-#{MatterIntake.count}" if @matter_intake.matter_number.blank?
    @matter_intake.user_id = current_user.id if @matter_intake.user_id.blank?

    if @matter_intake.valid?
      @matter_intake.status = 'submitted'
      @matter_intake.lawyer_reviewed_at = Time.now
      @matter_intake.save
      @matter_intake.auto_approve_matter(current_user)
      @matter_intake.set_default_approval_status(current_user)
      @matter_intake.send_notification_to_lawyer
      if params[:commit] === "Next"
        flash[:alert]=''
        @show_information_security_form = true
        redirect_to matter_intakes_information_security_classification_lob_matter_intakes_path(@matter_intake)
      else
        flash[:notice] = "Matter Intake Form submitted"
        redirect_to lob_matter_intake_path(@matter_intake)
      end
    else
      flash[:alert] = "There was an error initiating matter intake request. #{@matter_intake.errors.full_messages.join(', ')}" 
      render :new
    end
  end

  def information_security_classification
    @matter_intake = MatterIntake.find_by(id: params[:matter_intake_id])
  end

  def update
  	@matter_intake = MatterIntake.find_by(id: params[:id])

    if @matter_intake.update(matter_intake_params)
      @matter_intake.auto_approve_matter(current_user)
      if params[:matter_intake] && params[:commit] === "Next1" && params[:matter_intake][:submit_type] && params[:matter_intake][:submit_type] === "update"
        redirect_to matter_intakes_information_security_classification_lob_matter_intakes_path(@matter_intake)
      else
        flash[:notice] = "Matter intake request updated"
        redirect_to lob_matter_intake_path(@matter_intake)
      end
    else
      msg = "There was an error updating matter intake request #{@matter_intake.errors.full_messages.join(", ")}"
      @matter_intake = MatterIntake.find_by(id: params[:id])
      @current_lob_user = current_lob_user
      flash[:alert] = msg
      render :edit
    end
  end

  def show
    @matter_intake = MatterIntake.includes(:invoices).find_by(id: params[:id])
    @matter_approval = @matter_intake.current_user_pending_approval(current_user)
  end

  def add_review
    matter_intake = MatterIntake.find_by_id params[:id]
    matter_intake.reviews.create(status: 'comment', description: params[:discription], actor_id: current_user.id)
    redirect_to lob_matter_intake_path(matter_intake), notice: 'Your comment has been added.'
  end

  private
  def matter_intake_params
    params.require(:matter_intake).permit(
      :user_id, :submitter_name, :lob_contact_name, :name_of_matter_client, :matter_type_id, :asset,
      :matter_description, :mode_of_payment, :law_firm_id, :bmo_lawyer_name, :lawyer_id, :budget_amount,
      :lob_id, :lob_contact_for_po, :cost_centre_for_legal_fees, :paying_entity, :business_paying_for_matter,
      :group_paying_for_matter, :status, :lob_submitted_at, :legal_group_of_bmo_lawyer, :work_area, :work_area_type, :is_ore_reportable,
      :is_otherwise_reportable, :is_syndicate_matter, :is_conceal_imanage_workspace, :is_paper_file, :who_requires_access_to_imanage_workspace,
      :jurisdiction, :firm_type, :name_of_panel_firm, :name_of_non_panel_firm, :type_of_price, :additional_comments_for_lrc_lawyer,
      :is_alternative_fee_arrangement, :afa_details, :additional_matter_contact, :other_matter_issues, :firm_type,
      :primary_issue, :can_reimbursed_matter, :form_type,
      :lawyer_reviewed_at, :other_party, :deal_code, :outside_counsel_engaged, :stage_of_litigation, :line_of_business_id,
      :requested_by_id, :related_matter_number, :pii_involved, :internal_file_number, :business_department, :business_group, :matter_number,
      :receive_personal_information, :receive_general_business_data, :applicable_technical_specialty_data,
      applicable_technical_specialty_data_type: [], receive_personal_information_data_type: [], receive_general_business_data_type: [], external_lawyer_ids: [], lawyer_ids: [],
      invoices_attributes: [:id, :matter_intake_id, :lawyer_name, :rate_type, :description, :hours, :amount, :date, :taxes, :_destroy, invoice_attachments_attributes: [:id, :file]],
      matter_intake_attachments_attributes: [:id, :doc_type, :file, :_destroy]
    )
  end

end