class Admin::MatterIntakesController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Dashboard", :root_path

  def index
    @q = MatterIntake.ransack(params[:q])
    @current_user = current_user
    if current_user.role === "internal_lawyers"
      @matter_intakes = @q.result(distinct: true).where(lawyer_id: current_user.id).order('created_at DESC')
    elsif current_user.role === "lxp"
      @matter_intakes = @q.result(distinct: true).where(status: "waiting_for_lxp_review").or(@q.result(distinct: true).where(status: "matter_open")).order('created_at DESC')
    else
      @matter_intakes = []
    end
    add_breadcrumb "Matter Intakes", :admin_matter_intakes_path
  end

  def new
    @matter_intake = MatterIntake.new
    @current_user = current_user
  end

  def show
    @matter_intake = MatterIntake.find_by(id: params[:id])
  end

  def review
    @matter_intake = MatterIntake.find_by(id: params[:id])
  end

  def lxp_review
    @matter_intake = MatterIntake.find_by(id: params[:id])
  end

  def create
    @matter_intake = MatterIntake.new(matter_intake_params)
    
    if @matter_intake.save
      @matter_intake.update_attributes(status: "waiting_for_lxp_review", lawyer_reviewed_at: Time.now)
      @matter_intake.send_notification_to_lxp
      flash[:notice] = "Matter intake form saved"
      redirect_to :admin_matter_intakes
    else
      flash[:alert] = "There was an error initiating matter intake request. #{@matter_intake.errors.full_messages.join(', ')}" 
      render :new
    end

  end

  def update
    @matter_intake = MatterIntake.find_by(id: params[:id])
    if @matter_intake.present? && @matter_intake.update_attributes(matter_intake_params)
      if current_user.role === "internal_lawyers"
        @matter_intake.update_attributes(lawyer_reviewed_at: Time.now, status: 'waiting_for_lxp_review')
        @matter_intake.send_notification_to_lxp
        @matter_intake.add_log_for_lawyer_submission_to_lxp(current_user)
        flash[:notice] = "Matter intake Form-B saved."
      elsif current_user.role === "lxp" && @matter_intake.matter_number.present?
        @matter_intake.update_attributes(lxp_reviewed_at: Time.now, status: 'matter_open', lxp_id: current_user.id)
        @matter_intake.add_log_matter_open_by_lxp(current_user)
        @matter_intake.send_notification_to_lawyer_and_lxp
        flash[:notice] = "Matter opened in T360 with matter number #{@matter_intake.matter_number}."
      end
      redirect_to admin_matter_intakes_path
    else
      flash[:alert] = "There was an error updating matter intake request. #{@matter_intake.errors.full_messages.join(', ')}"
      @matter_intake = MatterIntake.find_by(id: params[:id])
      @current_lxp_user = current_user
      render :review,  id: @matter_intake.id
    end
  end

  def lxp_rejects
    @matter_intake = MatterIntake.find_by(id: params[:id])
    if current_user.role === "lxp"
      if @matter_intake.update_attributes(lxp_reviewed_at: Time.now, status: 'waiting_for_lawyer_update', lxp_id: current_user.id)
        @matter_intake.add_log_for_lxp_rejects_and_returns_to_lawyer(current_user)
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

  private
  def matter_intake_params
    params.require(:matter_intake).permit(
      :user_id, :submitter_name, :lob_contact_name, :name_of_matter_client, :matter_type_id,
      :matter_description, :mode_of_payment, :law_firm_id, :bmo_lawyer_name, :lawyer_id, :budget_amount,
      :lob_id, :lob_contact_for_po, :cost_centre_for_legal_fees, :paying_entity, :business_paying_for_matter,
      :group_paying_for_matter, :status, :lob_submitted_at, :legal_group_of_bmo_lawyer, :work_area, :is_ore_reportable,
      :is_otherwise_reportable, :is_syndicate_matter, :is_conceal_imanage_workspace, :is_paper_file,
      :jurisdiction, :firm_type, :name_of_panel_firm, :name_of_non_panel_firm, :type_of_price,
      :is_alternative_fee_arrangement, :afa_details, :additional_matter_contact, :other_matter_issues,
      :lawyer_reviewed_at, :other_party, :matter_number
    )
  end

end