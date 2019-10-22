class Admin::ExceptionRequestsController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Dashboard", :root_path

  def index
    @q = ExceptionRequest.ransack(params[:q])
    if current_user.role === "lxp"
      @exception_requests = @q.result(distinct: true).order('created_at DESC')
    elsif current_user.role === "internal_lawyers"
      @exception_requests = @q.result(distinct: true).where(internal_lawyers_id: current_user.id).order('created_at DESC')
    else
      @exception_requests = @q.result(distinct: true).where(user_id: current_user.id).order('created_at DESC')
    end
   
    add_breadcrumb "Exception request", :admin_exception_requests_path
  end

  def show
    @exception_request = ExceptionRequest.find(params[:id])
    if !@exception_request.user.try(:google_secret)
      @exception_request.user.try(:set_google_secret)
    end
    @law_firms = LawFirm.find_by_id(@exception_request.law_firm_name)
    add_breadcrumb "#{@exception_request.requested_by}", :admin_exception_request_path 
  end

  def download_pdf
    
    @exception_request = ExceptionRequest.find(params[:exception_request_id])
    document_name = @exception_request.get_document_name.gsub(".pdf","-signed.pdf")
    send_data @exception_request.get_document_list, filename: document_name
  end

  def create

    @exception_request = ExceptionRequest.new(exception_requests_params)
    authorize! :create, @exception_request
    if @exception_request.save
      ExceptionRequestMailer.form_submission_notification_to_lob(@exception_request).deliver_now
      ExceptionRequestMailer.form_submission_notification_to_lxp(@exception_request).deliver_now
      flash[:notice] = "Exception request saved"
      redirect_to :admin_exception_requests
    else
      @law_firms = LawFirm.all
      @current_admin_user_email = current_user.email
      @current_admin_user_id = current_user.id
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
      @law_firms = LawFirm.all
      @current_admin_user_email = current_user.email
      @current_admin_user_id = current_user.id
      flash[:alert] = "There was an error submiting the exception request"
      render :new
    end
  end

  def new
    @exception_request = ExceptionRequest.new
    authorize! :create, @exception_request
    @law_firms = LawFirm.all
    @current_admin_user_email = current_user.email
    @current_admin_user_id = current_user.id
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
      :business_manager_name, :business_manager_phone, :business_manager_email,
      :women_owned, :women_owned_details, :matter_name, :law_firm_name, matter_types: []
    )
  end

end
