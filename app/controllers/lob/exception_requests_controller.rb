class Lob::ExceptionRequestsController < Lob::BaseController

  layout 'lob'

  add_breadcrumb "Dashboard", :root_path

  def index
    @q = ExceptionRequest.ransack(params[:q])
    @exception_requests = @q.result(distinct: true).where(user_id: current_user.id).order('created_at DESC')   
    add_breadcrumb "Exception request", :admin_exception_requests_path
  end

  def show
    @exception_request = ExceptionRequest.find(params[:id])

    if !@exception_request.user.try(:google_secret)
      @exception_request.user.try(:set_google_secret)
    end
    @law_firm = LawFirm.find_by_id(@exception_request.law_firm_id)
    add_breadcrumb "#{@exception_request.requested_by}", :admin_exception_request_path 
  end

  def create
    @exception_request = ExceptionRequest.new(exception_requests_params)
    @law_firm = LawFirm.find_by_id(params[:exception_request][:law_firm_id])
    if @exception_request.save

      if params[:exception_request][:is_work] === "Yes"
        ExceptionRequestMailer.engage_non_panel_firm_notification_to_lxp(@exception_request).deliver_now
        flash[:notice] = "Exception request saved"
        redirect_to :lob_exception_requests
      else
        redirect_to exception_request_new_engage_lob_exception_requests_path(@exception_request)
        # ExceptionRequestMailer.form_submission_notification_to_lob(@exception_request).deliver_now
        # ExceptionRequestMailer.form_submission_notification_to_lxp(@exception_request).deliver_now
      end
     
      
    else
      @current_admin_user_email = current_user.email
      @current_admin_user_id = current_user.id
      flash[:alert] = "There was an error submiting the exception request"
      render :new, :law_firm_id => params[:exception_request][:law_firm_id]
      
    end
    
  end

  def new_engage_non_panel_firm
    @exception_request = ExceptionRequest.find_by_id(params[:exception_request_id])
    @law_firm = LawFirm.new
    @current_admin_user_email = current_user.email
    @current_admin_user_id = current_user.id
  end

  def update
    binding.pry
  	@exception_request = ExceptionRequest.find(params[:id])
    if @exception_request.update_attributes(exception_requests_params)
      flash[:notice] = "Exception request updated"
      redirect_to lob_exception_request_path
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
    @law_firm = LawFirm.find_by_id(params[:law_firm_id])
    @current_admin_user_email = current_user.email
    @current_admin_user_id = current_user.id
  end


  def engage_non_panel_firm
     @law_firm = LawFirm.new
     @exception_request = ExceptionRequest.new
     @current_admin_user_email = current_user.email
     @current_admin_user_id = current_user.id
  end


  def get_sub_matter_types
    if params[:id]
      render json: { data: SubMatterType.where(matter_type_id: params[:id]) }
    else
      render json: { data: [] }
    end
  end

  def get_state
    if params[:id]
      @countries = Country.select("country_id").where(id: params[:id])
      render json: { data: State.where(country_id: @countries) }
    else
      render json: { data: [] }
    end
  end

  def get_law_firm_list
    if params[:matter_type].present? ||  params[:sub_matter_type].present? || params[:jurisdiction_type].present? || params[:country].present? || params[:state].present?
      render json: { data: LawFirm.all }
    else
      render json: { data: [] }
    end
  end


  def select_law_firm
    @exception_request = ExceptionRequest.new
   if params[:id]
    @law_firm = LawFirm.find_by_id(params[:id])
   else
    @law_firms = LawFirm.all
   end
  end

  def edit
    @exception_request = ExceptionRequest.find(params[:id])
    @law_firm = LawFirm.find_by_id(@exception_request.law_firm_id)
    @current_admin_user_email = @exception_request.submitted_by_email
    @current_admin_user_id = @exception_request.user_id

    add_breadcrumb "#{@exception_request.requested_by}", :admin_exception_request_path 
    
  end
 
  def law_firm_new  
    @law_firm = LawFirm.new
    @current_user_id = current_user.id
  end

  def law_firm_create
   
    @law_firm = LawFirm.new(law_firms_params)
    params[:law_firm][:law_firms_matter_types_attributes]  =  []
    # params[:law_firm][:matter_type_ids].each do |mt|
    #   if !mt.blank?
    #     params[:law_firm][:law_firms_matter_types_attributes][:matter_type_id] << mt
    #   end
    # end
    # binding.pry
    @current_user_id = current_user.id
    if @law_firm.save

      # params[:law_firm][:matter_type_ids].each do |mt|
      #   if !mt.blank?
      #     LawFirmsMatterType.create(law_firm_id: @law_firm.id, matter_type_id: mt)
      #   end
      # end

      flash[:notice] = "New Law firm created"
      redirect_to exception_request_new_lob_exception_requests_path(@law_firm)

      
  	else
  		flash.now[:alert] = @law_firm.errors.full_messages.join(',')
  		render :law_firm_new
  	end
  end
  private

  def exception_requests_params
    
    params.require(:exception_request).permit(
      :requested_by, :submitted_by_email, :user_id, :line_of_business, :notes,
      :lob_contact_name, :law_firm_id, :request_type,
      :law_firm_category, :minority_owned, :minority_owned_details,
      :business_manager_name, :business_manager_phone, :business_manager_email, :is_work, :payer,
      :matter_types_search, :sub_matter_types_search, :jurisdiction_types_search, :countries_search, :states_search,
      :women_owned, :women_owned_details, :matter_name, :law_firm_name, matter_types: [], reason: []
    )
  end

  def law_firms_params
    params.require(:law_firm).permit(
      :name, :description, :email, :phone, :user_id, :relationship_manager_email,
      :relationship_manager_name, :relationship_manager_phone,
      :law_firm_type, :law_firm_category,
      #law_firms_matter_types_attributes: [:matter_type_id]
      matter_type_ids:[], sub_matter_type_ids: [], jurisdiction_type_ids: [], state_ids: [], country_ids: []
    )
  end

end
