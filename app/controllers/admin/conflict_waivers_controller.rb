class Admin::ConflictWaiversController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Dashboard", :root_path

  def index 
    @q = ConflictWaiver.ransack(params[:q])
    @conflict_waivers = @q.result.order('created_at DESC')
    add_breadcrumb "Conflict Waiver", :admin_conflict_waivers_path
  end

  def show
    
  end

  def create

    @conflict_waiver = ConflictWaiver.new(conflict_waivers_params)

    if @conflict_waiver.save
      flash[:notice] = "Conflict Waiver saved"
      redirect_to :admin_conflict_waivers
    else
     
      flash[:alert] = "There was an error submiting the Conflict Waiver"
      redirect_back fallback_location: new_admin_conflict_waiver_path
      
    end
    
  end

  def update
  	@conflict_waiver = ConflictWaiver.find(params[:id])
    if @conflict_waiver.update_attributes(conflict_waivers_params)
      flash[:notice] = "Conflict Waiver updated"
      redirect_to admin_conflict_waiver_path(@conflict_waiver)
    else
      flash[:alert] = "error"
      redirect_back fallback_location: admin_conflict_waivers
    end
  end

  def new
  	@conflict_waiver = ConflictWaiver.new
    @current_admin_user_email = current_admin_user.email
    @current_admin_user_id = current_admin_user.id
  end

  def edit
    @conflict_waiver = ConflictWaiver.find(params[:id])
    @current_admin_user_id = @conflict_waiver.user_id

    add_breadcrumb "#{@conflict_waiver.name_of_law_firm}", :admin_conflict_waiver_path 
    
  end
 

  private

  def conflict_waivers_params
    
    params.require(:conflict_waiver).permit(
      :name_of_law_firm, :contact_details, :user_id, :bmo_business_contact,
      :reason
    )
  end

end
