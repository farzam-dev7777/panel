class Admin::ExceptionRequestsController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Dashboard", :root_path

  def index
    @q = ExceptionRequest.ransack(params[:q])
    @exception_requests = @q.result.order('created_at DESC')
    add_breadcrumb "Exception request", :admin_exception_requests_path
  end

  def show
    
  end

  def create

    @exception_request = ExceptionRequest.new(exception_requests_params)

    if @exception_request.save
      flash[:notice] = "Exception request saved"
      redirect_to :admin_exception_requests
    else
      @law_firms = LawFirm.all
      @current_admin_user_email = current_admin_user.email
      @current_admin_user_id = current_admin_user.id
      flash[:alert] = "There was an error submiting the exception request"
      render :new
      
    end
    
  end

  def update
  	@exception_request = ExceptionRequest.find(params[:id])
    if @exception_request.update_attributes(exception_requests_params)
      flash[:notice] = "Exception request updated"
      redirect_to admin_exception_request_path(@exception_request)
    else
      flash[:alert] = "error"
      redirect_back fallback_location: admin_exception_requests
    end
  end

  def new
  	@exception_request = ExceptionRequest.new
    @law_firms = LawFirm.all
    @current_admin_user_email = current_admin_user.email
    @current_admin_user_id = current_admin_user.id
  end

  def edit
    @exception_request = ExceptionRequest.find(params[:id])
    @law_firms = LawFirm.all
    @current_admin_user_email = @exception_request.submitted_by_email
    @current_admin_user_id = @exception_request.user_id

    add_breadcrumb "#{@exception_request.requested_by}", :admin_exception_request_path 
    
  end
 

  private

  def exception_requests_params
    
    params.require(:exception_request).permit(
      :requested_by, :submitted_by_email, :user_id, :line_of_business,
      :lob_contact_name, :law_firm_id, :request_type,
      :law_firm_category, :minority_owned, :minority_owned_details,
      :women_owned, :women_owned_details, :matter_name   #, matter_types: []
    )
  end

end
