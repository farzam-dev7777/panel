class TenantAdmin::TenantDashboardController < TenantAdmin::BaseController
  layout 'tenant_admin'

  add_breadcrumb "Dashboard", :root_path

  def index
    @q = Tenant.ransack(params[:q])
    @tenants = @q.result(distinct: true).order('created_at DESC')
  end
end