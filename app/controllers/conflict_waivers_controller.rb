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
   
      @conflict_waiver.update_attributes(lxp_status: "IN_REVIEW")
      redirect_to conflict_waivers_client_info_conflict_waivers_path(@conflict_waiver)

      # @conflict_waiver.log_activity('conflict_waiver_submited', true, current_user)
      
      # ConflictWaiverMailer.form_submited_notification_to_lxp(@conflict_waiver).deliver_now
      # ConflictWaiverMailer.form_submited_notification_to_user(@conflict_waiver).deliver_now
      # flash[:notice] = "Conflict Waiver saved"
      # redirect_to :conflict_waivers
      
    else
      flash[:alert] = "There was an error submiting the Conflict Waiver"
      render :new
    end
    
  end


  def client_info
    @conflict_waiver = ConflictWaiver.find(params[:conflict_waiver_id])
  end

  def client_info_update

    if params[:conflict_waiver] && params[:conflict_waiver][:conflict_waiver_id] 
      @conflict_waiver = ConflictWaiver.find(params[:conflict_waiver][:conflict_waiver_id])
      if @conflict_waiver.update_attributes(conflict_waivers_params)
        @conflict_waiver.log_activity('conflict_waiver_submited', true, current_user)
        if current_law_firm.present? && @conflict_waiver.internal_lawyers_status != "APPROVED"
          @conflict_waiver.update_attributes(internal_lawyers_status: "IN_REVIEW", lxp_status: "IN_REVIEW")
        end 
        ConflictWaiverMailer.form_submited_notification_to_lxp(@conflict_waiver).deliver_now
        ConflictWaiverMailer.form_submited_notification_to_user(@conflict_waiver).deliver_now
        flash[:notice] = "Conflict Waiver Request submitted"
        redirect_to :root
        
      else
        flash[:alert] = "There was an error submiting the Conflict Waiver"
        redirect_to conflict_waivers_client_info_conflict_waivers_path(@conflict_waiver)
      end
    else
      flash[:notice] = "Conflict Waiver Not Submited."
      redirect_to :conflict_waivers
    end  
   
  end



  def update
    @conflict_waiver = ConflictWaiver.find(params[:id])
   
    if @conflict_waiver.update_attributes(conflict_waivers_params)
      
      # ConflictWaiverMailer.form_update_notification_to_user(@conflict_waiver).deliver_now
      # ConflictWaiverMailer.form_updated_notification_to_lxp(@conflict_waiver).deliver_now
      # redirect_to :conflict_waivers
      redirect_to conflict_waivers_client_info_conflict_waivers_path(@conflict_waiver)
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
    @current_user = @conflict_waiver.user
    @current_user_id = @conflict_waiver.user_id

    add_breadcrumb "#{@conflict_waiver.name_of_law_firm}", :conflict_waiver_path 
    
  end
 

  private

  def conflict_waivers_params
    
    params.require(:conflict_waiver).permit(
      :name_of_law_firm, :contact_details, :user_id, :bmo_business_contact, :reason, :confirm_waiver, :assigned_to_id, :retainer_language, :repesenting, :name_of_other_client, :description_of_transaction, :nature_of_mandate, :office_locattion, :names_of_primary, 
      types_of_matters: []
    )
  end


end
