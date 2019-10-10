class Admin::ConflictWaiversController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Dashboard", :root_path

  def index 
    if current_user.role === "internal_lawyers"
      @conflict_waivers = ConflictWaiver.where(assigned_to_id: current_user.id).order('created_at DESC')
    else
      @q = ConflictWaiver.ransack(params[:q])
      @conflict_waivers = @q.result.order('created_at DESC')
    end
    add_breadcrumb "Conflict Waiver", :admin_conflict_waivers_path
  end

  def show
    @conflict_waiver = ConflictWaiver.find(params[:id])
  end

  def create

    @conflict_waiver = ConflictWaiver.new(conflict_waivers_params)
    authorize! :create, @conflict_waiver
    if @conflict_waiver.save
      flash[:notice] = "Conflict Waiver saved"
      redirect_to :admin_conflict_waivers
    else
     
      flash[:alert] = "There was an error submiting the Conflict Waiver"
      render :new

      
    end
    
  end

  def update

  	@conflict_waiver = ConflictWaiver.find(params[:id])
    if @conflict_waiver.update_attributes(conflict_waivers_params)
      
       if params[:conflict_waiver][:lxp_status].present?
        @current_user =  User.find_by_id(@conflict_waiver.user_id)
       end
      flash[:notice] = "Conflict Status updated"
      redirect_to :admin_conflict_waivers
    else
      flash[:alert] = "There was an error submiting the Conflict Waiver"
      render :new
    end
  end

   
  def new
    @conflict_waiver = ConflictWaiver.new
    authorize! :create, @conflict_waiver
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
      :name_of_law_firm, :contact_details, :user_id, :bmo_business_contact, :reason, :confirm_waiver, :lxp_status, :assigned_to_id
    )
  end

end
