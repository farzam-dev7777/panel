class TenantAdmin::TenantsController < TenantAdmin::BaseController
  layout 'tenant_admin'

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

  private

  def tenant_params
    params.require(:tenant).permit(
      :name, :subdomain, :primary_color, :secondary_color, :logo, :login_bg_image
    )
  end

end