class Lob::MatterIntakesController < Lob::BaseController

  layout 'lob'

  add_breadcrumb "Dashboard", :root_path

  def index
    @q = MatterIntake.ransack(params[:q])
    @matter_intakes = @q.result(distinct: true).where(user_id: current_user.id).order('created_at DESC')   
    add_breadcrumb "Matter intake", :lob_matter_intakes_path
  end

  def new
    @matter_intake = MatterIntake.new
    @current_lob_user = current_lob_user
  end

  def edit
    @matter_intake = MatterIntake.find_by(id: params[:id])
    @current_lob_user = current_lob_user

    add_breadcrumb "#{@matter_intake.submitter_name}", :lob_matter_intake_path 
    
  end

  def create
    @matter_intake = MatterIntake.new(matter_intake_params)
    
    if @matter_intake.save
      @matter_intake.update_attributes(status: "waiting_for_lawyer_review", lob_submitted_at: Time.now)
      @matter_intake.send_notification_to_lawyer
      flash[:notice] = "Matter Intake Form submitted"
      redirect_to :lob_matter_intakes
    else
      flash[:alert] = "There was an error initiating matter intake request. #{@matter_intake.errors.full_messages.join(', ')}" 
      @matter_intake = MatterIntake.new
      @current_lob_user = current_lob_user
      render :new
    end

  end

  def update
  	@matter_intake = MatterIntake.find_by(id: params[:id])
    if @matter_intake.update_attributes(matter_intake_params)
      flash[:notice] = "Matter intake request updated"
      redirect_to lob_matter_intake_path(@matter_intake)
    else
      @matter_intake = MatterIntake.find_by(id: params[:id])
      @current_lob_user = current_lob_user
      flash[:alert] = "There was an error updating matter intake request"
      render :new
    end
  end

  def show
    @matter_intake = MatterIntake.find_by(id: params[:id])
  end

  private
  def matter_intake_params
    params.require(:matter_intake).permit(
      :user_id, :submitter_name, :lob_contact_name, :name_of_matter_client, :matter_type_id,
      :matter_description, :mode_of_payment, :law_firm_id, :bmo_lawyer_name, :lawyer_id, :budget_amount,
      :lob_id, :lob_contact_for_po, :cost_centre_for_legal_fees, :paying_entity, :business_paying_for_matter,
      :group_paying_for_matter, :status, :lob_submitted_at, :legal_group_of_bmo_lawyer, :work_area, :work_area_type, :is_ore_reportable,
      :is_otherwise_reportable, :is_syndicate_matter, :is_conceal_imanage_workspace, :is_paper_file,
      :jurisdiction, :firm_type, :name_of_panel_firm, :name_of_non_panel_firm, :type_of_price, :additional_comments_for_lrc_lawyer,
      :is_alternative_fee_arrangement, :afa_details, :additional_matter_contact, :other_matter_issues,
      :lawyer_reviewed_at, :other_party, :following_matter_involve, :deal_code
    )
  end

end