class Admin::PanelRequestsController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Dashboard", :root_path

  def index
    @q = PanelRequest.ransack(params[:q])
    @panel_requests = @q.result.order('created_at DESC')
    add_breadcrumb "Panel request", :admin_panel_requests_path
  end

  def show
    @panel_request = PanelRequest.find(params[:id])
    if !@panel_request.user.try(:google_secret)
      @panel_request.user.try(:set_google_secret)
    end
    @law_firms = LawFirm.find_by_id(@panel_request.law_firm_id)
    add_breadcrumb "#{@panel_request.requested_by}", :admin_exception_request_path 
    add_breadcrumb "#{@panel_request.requested_by}", :admin_panel_request_path 
  end

  def create
    @panel_request = PanelRequest.new(panel_requests_params)
    if @panel_request.save
      flash[:notice] = "Panel request saved"
      redirect_to :admin_panel_requests
    else
      @law_firms = LawFirm.all
      @current_admin_user_email = current_admin_user.email
      @current_admin_user_id = current_admin_user.id
      flash[:alert] = "There was an error submiting the Panel request"
      render :new
      
    end
    
  end

  def update
  	@panel_request = PanelRequest.find(params[:id])
    if @panel_request.update_attributes(panel_requests_params)
      flash[:notice] = "Panel request updated"
      redirect_to admin_panel_request_path(@panel_request)
    else
      @law_firms = LawFirm.all
      @current_admin_user_email = current_admin_user.email
      @current_admin_user_id = current_admin_user.id
      flash[:alert] = "There was an error submiting the exception request"
      render :new
    end
  end

  def new
    @panel_request = PanelRequest.new
    @panel_request.build_law_firm
    @current_admin_user_email = current_admin_user.email
    @current_admin_user_id = current_admin_user.id
  end

  def edit
    @panel_request = PanelRequest.find(params[:id])
    @current_admin_user_email = @panel_request.submitted_by_email
    @current_admin_user_id = @panel_request.user_id

    add_breadcrumb "#{@panel_request.requested_by}", :admin_panel_request_path 
    
  end
 

  private

  def panel_requests_params
    
    params.require(:panel_request).permit(
      :requested_by, :submitted_by_email, :user_id, :line_of_business,
      :lob_contact_name, :law_firm_id, :request_type,
      :business_manager_name, :business_manager_phone, :business_manager_email,
      :law_firm_category, :minority_owned, :minority_owned_details,
      :women_owned, :women_owned_details, :law_firm_name,  matter_types: [], law_firm_attributes: [:name, :email, :phone, :description, :relationship_manager_name, :relationship_manager_email, :relationship_manager_phone, :temp_password, :temp_password_confirmation ]
    )
  end

end