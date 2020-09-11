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
      errors = @panel_request.errors.full_messages.join(', ')
      @law_firms = LawFirm.all
      @current_admin_user_email = current_admin_user.email
      @current_admin_user_id = current_admin_user.id
      flash[:alert] = "There was an error submiting the Panel request: #{errors}"
      render :new
      
    end
    
  end

  def update
  	@panel_request = PanelRequest.find(params[:id])
    if @panel_request.update_attributes(update_panel_requests_params)
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
    @law_firm =  @panel_request.build_law_firm
    @user = @law_firm.users.build     
    @current_admin_user_email = current_admin_user.email
    @current_admin_user_id = current_admin_user.id
  end

  def edit
    @panel_request = PanelRequest.find(params[:id])
    @current_admin_user_email = @panel_request.submitted_by_email
    @current_admin_user_id = @panel_request.user_id

    add_breadcrumb "#{@panel_request.requested_by}", :admin_panel_request_path 
    
  end

  def download_pdf
    
    @panel_request = PanelRequest.find(params[:panel_request_id])
    document_name = @panel_request.get_document_name.gsub(".pdf","-signed.pdf")
    send_data @panel_request.get_document_list, filename: document_name
  end

  def send_wnn_documents
    @panel_request = PanelRequest.find_by(id: params[:id])
    @law_firm = @panel_request&.law_firm
    if @panel_request.present? && @law_firm.present? && @law_firm.email.present?
      if PanelRequestMailer.send_wnn_documents_to_law_firm(@panel_request).deliver_now
        render json: {
          message: "WNN Documents sent in email successfully.",
          title: "Success",
          icon: "success"
        }
      else
        render json: {
          message: "WNN Documents not sent.",
          title: "Opps!",
          icon: "error"
        }
      end
    else
      render json: {
        message: "WNN Documents not sent. Law Firm/ Email not found.",
        title: "Opps!",
        icon: "error"
      }
    end
  end

  private

  def panel_requests_params
    params.require(:panel_request).permit(
      :requested_by, :submitted_by_email, :user_id, :line_of_business,
      :lob_contact_name, :law_firm_id, :request_type,
      :business_manager_name, :business_manager_phone, 
      :business_manager_email, :minority_owned, :minority_owned_details, :reason_other, :involved_engagement, :geographic_location,
      :required_unique_geography, :niche_expertise, :niche_preferred_external_counsel_panel_law_firms, 
      :women_owned, :women_owned_details, :law_firm_name, :status, matter_types: [],
      law_firm_attributes: [
        :name, :law_firm_category, :status, :contact_name, :firm_use_on_regular_basis,
        :email, :phone, :description, :relationship_manager_name, 
        :relationship_manager_email, :relationship_manager_phone ,
        matter_type_ids:[], sub_matter_type_ids: [], jurisdiction_type_ids: [], state_ids: [], country_ids: [],
        users_attributes: [:email, :role, :empty_user, :status]
      ]
    )
  end
  def update_panel_requests_params
    params.require(:panel_request).permit(
      :requested_by, :submitted_by_email, :user_id, :line_of_business,
      :lob_contact_name, :law_firm_id, :request_type, :niche_preferred_external_counsel_panel_law_firms,
      :business_manager_name, :business_manager_phone, :niche_expertise, :required_unique_geography,
      :business_manager_email, :minority_owned, :minority_owned_details, :geographic_location, 
      :women_owned, :women_owned_details, :law_firm_name, :status, :involved_engagement, :reason_other, matter_types: [],
      law_firm_attributes: [
        :id, :name, :law_firm_category, :status,:contact_name, :firm_use_on_regular_basis,
        :email, :phone, :description, :relationship_manager_name, 
        :relationship_manager_email, :relationship_manager_phone ,
        matter_type_ids:[], sub_matter_type_ids: [], jurisdiction_type_ids: [], state_ids: [], country_ids: [],
        users_attributes: [:id, :email, :role, :empty_user, :status]
      ]
    )
  end

  
  # def panel_requests_params_test
  #   params.require(:panel_request).permit(
  #     :requested_by, :submitted_by_email, :user_id, :line_of_business,
  #     :lob_contact_name, :law_firm_id, :request_type,
  #     :business_manager_name, :business_manager_phone, 
  #     :business_manager_email, :minority_owned, :minority_owned_details,
  #     :women_owned, :women_owned_details, :law_firm_name, 
  #     matter_types: []
  #   )
  # end

  # def panel_requests_params
  #   params.require(:panel_request).permit(
  #     :requested_by, :submitted_by_email, :user_id, :line_of_business,
  #     :lob_contact_name, :law_firm_id, :request_type,
  #     :business_manager_name, :business_manager_phone, 
  #     :business_manager_email, :minority_owned, :minority_owned_details,
  #     :women_owned, :women_owned_details, :law_firm_name, 
  #     matter_types: [], 
  #     law_firm_attributes: [
  #       :name, :law_firm_category, 
  #       :email, :phone, :description, :relationship_manager_name, 
  #       :relationship_manager_email, :relationship_manager_phone ,
  #       users_attributes: [:email, :role, :empty_user]
  #     ]
  #   )
  # end
  

end



