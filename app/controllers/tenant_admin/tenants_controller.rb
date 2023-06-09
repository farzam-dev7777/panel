class TenantAdmin::TenantsController < TenantAdmin::BaseController
  layout 'tenant_admin'

  def show
    @tenant = Tenant.find_by(id: params[:id])
    @tenant_law_firms = LawFirmsTenant.where(tenant_id: @tenant&.id)
  end

  def new
    @tenant = Tenant.new
  end

  def create
    @tenant = Tenant.new(tenant_params)
    if @tenant.save
      flash[:notice] = "Tenant created successfully"
      redirect_to tenant_admin_root_path
    else
      flash[:alert] = "There was an error creating new tanant. Errors: #{@tenant&.errors&.full_messages&.join(', ')}"
      render :new
    end
  end

  def edit
    @tenant = Tenant.find_by(id: params[:id])
  end

  def update
    @tenant = Tenant.find_by(id: params[:id])
    if @tenant.update(tenant_params)
      flash[:notice] = "Tenant updated successfully."
      redirect_to tenant_admin_root_path
    else
      flash.now[:alert] = "There was an error updating the tenant, errors: #{@tenant&.errors&.full_messages&.join(', ')}"
  		render :new
    end
  end

  def link_lawfirm
    @tenants = Tenant.all
    @law_firm_tenant = LawFirmsTenant.new
  end

  def create_law_firm_tenant
    existing_law_firm_tenant = LawFirmsTenant.find_by(tenant_id: law_firms_tenant_params&.fetch("tenant_id", ""), law_firm_id: law_firms_tenant_params&.fetch("law_firm_id", ""))
    if existing_law_firm_tenant.nil?
      @law_firm_tenant = LawFirmsTenant.new(law_firms_tenant_params)
      if @law_firm_tenant.save
        flash[:notice] = "Law firm linked with tenant successfully."
        redirect_to link_lawfirm_tenant_admin_tenants_path
      else
        flash.now[:alert] = "There was an error in linking law firm with tenant, errors: #{@law_firm_tenant&.errors&.full_messages&.join(', ')}"
        render :link_lawfirm
      end
    else
      flash.now[:alert] = "Law Firm already linked with tenant: #{existing_law_firm_tenant&.tenant&.subdomainß}"
      render :link_lawfirm
    end
  end

  def available_law_firms
    tenant = Tenant.find_by(id: params[:id])
    if tenant.present?
      already_linked_law_firm_id = LawFirmsTenant.where(tenant_id: tenant&.id)&.pluck(:law_firm_id)
      law_firm_ids = LawFirm&.pluck(:id)
      available_law_firm_ids = law_firm_ids - already_linked_law_firm_id 
      law_firms = LawFirm.where(id: available_law_firm_ids)
      render json: {law_firms: law_firms}
    else
      render json: {law_firms: []}
    end
  end

  private

  def tenant_params
    params.require(:tenant).permit(
      :name, :subdomain, :primary_color, :secondary_color, :logo, :login_bg_image,
      :okta_client_id, :okta_client_secret, :okta_site, :okta_api_token, :sso_type,
      :azure_client_id, :azure_client_secret, :azure_tenant_id, :internal_lawyer,
      :master_user, :business_user
    )
  end

  def law_firms_tenant_params
    params.require(:law_firms_tenant).permit(:tenant_id, :law_firm_id, :initial_date_of_engagement_with_the_bank)
  end

end