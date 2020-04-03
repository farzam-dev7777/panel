class Admin::MatterIntakesController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Dashboard", :root_path

  def index
    @q = MatterIntake.ransack(params[:q])
    if current_user.role === "internal_lawyers"
      @matter_intakes = @q.result(distinct: true).where(status: "waiting_for_lawyer_review").or(@q.result(distinct: true).where(status: "waiting_for_lawyer_update")).order('created_at DESC')
    end
   
    add_breadcrumb "Matter Intakes", :admin_matter_intakes_path
  end

  def new
    @matter_intake = MatterIntake.new
    @current_lxp_user = current_user
  end

  def show
    @matter_intake = MatterIntake.find_by(id: params[:id])
  end

  def review
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
      # @matter_intake = MatterIntake.new
      # @current_lxp_user = current_user
      render :new
    end

  end

  def update
    @matter_intake = MatterIntake.find_by(id: params[:id])
    if @matter_intake.present? && @matter_intake.update_attributes(matter_intake_params)
      @matter_intake.update_attributes(lawyer_reviewed_at: Time.now, status: 'waiting_for_lxp_review')
      @matter_intake.send_notification_to_lxp
      flash[:notice] = "Matter intake form saved."
      redirect_to admin_matter_intakes_path
    else
      flash[:alert] = "There was an error updating matter intake request. #{@matter_intake.errors.full_messages.join(', ')}"
      @matter_intake = MatterIntake.find_by(id: params[:id])
      @current_lxp_user = current_user
      render :review,  id: @matter_intake.id
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
      :lawyer_reviewed_at, :other_party
    )
  end

end