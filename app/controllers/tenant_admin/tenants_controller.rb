class TenantAdmin::TenantsController < TenantAdmin::BaseController
  layout 'tenant_admin'

  load_and_authorize_resource :class => "User"

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

  private

  def tenant_params
    params.require(:tenant).permit(
      :name, :subdomain, :primary_color, :secondary_color, :logo, :login_bg_image,
      :okta_client_id, :okta_client_secret, :okta_site, :okta_api_token, :sso_type,
      :azure_client_id, :azure_client_secret, :azure_tenant_id
    )
  end

end