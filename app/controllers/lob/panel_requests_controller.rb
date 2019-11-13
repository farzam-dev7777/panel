class Lob::PanelRequestsController < Lob::BaseController

  layout 'lob'

  add_breadcrumb "Dashboard", :root_path

  def index
    @q = PanelRequest.ransack(params[:q])
    @panel_requests = @q.result(distinct: true).where(user_id: current_user.id).order('created_at DESC')   
    add_breadcrumb "Panel request", :lob_panel_requests_path
  end

  def show
    @panel_request = PanelRequest.find(params[:id])
    if !@panel_request.user.try(:google_secret)
      @panel_request.user.try(:set_google_secret)
    end
    @law_firms = LawFirm.find_by_id(@panel_request.law_firm_id)
    add_breadcrumb "#{@panel_request.requested_by}", :lob_exception_request_path 
    add_breadcrumb "#{@panel_request.requested_by}", :lob_panel_request_path 
  end

  def create
    @panel_request = PanelRequest.new(panel_requests_params)
    if @panel_request.save
      flash[:notice] = "Panel request saved"
      redirect_to :lob_panel_requests
    else
      @law_firms = LawFirm.all
      @current_lob_user_email = current_lob_user.email
      @current_lob_user_id = current_lob_user.id
      flash[:alert] = "There was an error submiting the Panel request"
      render :new
      
    end
    
  end

  def update
  	@panel_request = PanelRequest.find(params[:id])
    if @panel_request.update_attributes(panel_requests_params)
      flash[:notice] = "Panel request updated"
      redirect_to lob_panel_request_path(@panel_request)
    else
      @law_firms = LawFirm.all
      @current_lob_user_email = current_lob_user.email
      @current_lob_user_id = current_lob_user.id
      flash[:alert] = "There was an error submiting the exception request"
      render :new
    end
  end

  def new
    @panel_request = PanelRequest.new
    @law_firm = @panel_request.build_law_firm
    @user = @law_firm.users.build       
    @current_lob_user_email = current_lob_user.email
    @current_lob_user_id = current_lob_user.id
  end

  def edit
    @panel_request = PanelRequest.find(params[:id])
    @current_lob_user_email = @panel_request.submitted_by_email
    @current_lob_user_id = @panel_request.user_id

    add_breadcrumb "#{@panel_request.requested_by}", :lob_panel_request_path 
    
  end
 

  private
  def panel_requests_params_test
    params.require(:panel_request).permit(
      :requested_by, :submitted_by_email, :user_id, :line_of_business,
      :lob_contact_name, :law_firm_id, :request_type,
      :business_manager_name, :business_manager_phone, 
      :business_manager_email, :minority_owned, :minority_owned_details,
      :women_owned, :women_owned_details, :law_firm_name, 
      matter_types: []
    )
  end

  def panel_requests_params
    params.require(:panel_request).permit(
      :requested_by, :submitted_by_email, :user_id, :line_of_business,
      :lob_contact_name, :law_firm_id, :request_type,
      :business_manager_name, :business_manager_phone, 
      :business_manager_email, :minority_owned, :minority_owned_details,
      :women_owned, :women_owned_details, :law_firm_name, 
      matter_types: [], 
      law_firm_attributes: [
        :name, :law_firm_category, 
        :email, :phone, :description, :relationship_manager_name, 
        :relationship_manager_email, :relationship_manager_phone ,
        users_attributes: [:email, :role, :empty_user]
      ]
    )
  end

end