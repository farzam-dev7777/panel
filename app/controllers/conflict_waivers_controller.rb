class ConflictWaiversController < BaseController
    
  def index 
    @conflict_waivers = current_law_firm.conflict_waivers
    add_breadcrumb "Conflict Waiver", :conflict_waivers_path
  end

  def show
    @conflict_waiver = ConflictWaiver.find(params[:id])
  end

  def create
    @conflict_waiver = current_law_firm.conflict_waivers.build(conflict_waivers_params)
    @current_user = current_user
    if @conflict_waiver.save
      @conflict_waiver.log_activity('conflict_waiver_submited', true, current_user)
     
      ConflictWaiverMailer.form_submited_notification_to_lxp(@conflict_waiver).deliver_now
      ConflictWaiverMailer.form_submited_notification_to_user(@conflict_waiver).deliver_now
      flash[:notice] = "Conflict Waiver saved"
      redirect_to :conflict_waivers
    else
      flash[:alert] = "There was an error submiting the Conflict Waiver"
      render :new
    end
    
  end

  def update
    @conflict_waiver = ConflictWaiver.find(params[:id])

    if @conflict_waiver.update_attributes(conflict_waivers_params)
      flash[:notice] = "Conflict Waiver updated"
      ConflictWaiverMailer.form_update_notification_to_user(@conflict_waiver).deliver_now
      ConflictWaiverMailer.form_updated_notification_to_lxp(@conflict_waiver).deliver_now
      redirect_to :conflict_waivers
    else
      flash[:alert] = "There was an error submiting the Conflict Waiver"
      render :new
    end
  end

  def new
    @conflict_waiver = ConflictWaiver.new
    @current_user_email = current_user.email
    @current_user_id = current_user.id
  end

  def edit
    @conflict_waiver = ConflictWaiver.find(params[:id])
    @current_user_id = @conflict_waiver.user_id

    add_breadcrumb "#{@conflict_waiver.name_of_law_firm}", :conflict_waiver_path 
    
  end
 

  private

  def conflict_waivers_params
    
    params.require(:conflict_waiver).permit(
      :name_of_law_firm, :contact_details, :user_id, :bmo_business_contact, :reason, :confirm_waiver, :assigned_to_id, :retainer_language
    )
  end


end
