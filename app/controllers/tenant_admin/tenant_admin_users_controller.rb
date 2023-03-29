class TenantAdmin::TenantAdminUsersController < TenantAdmin::BaseController
  layout 'tenant_admin'

  def index
    @q = TenantAdminUser.ransack(params[:q])
    @tenant_admins = @q.result(distinct: true).order('created_at DESC')
  end

  def new
    @tenant_admin_user = TenantAdminUser.new
  end

  def edit
    @tenant_admin_user = TenantAdminUser.find_by(id: params[:id])
  end

  def create
    @tenant_admin_user = TenantAdminUser.new(tenant_admin_user_params)
    @tenant_admin_user.role = "tenant_admin"
    if @tenant_admin_user.save
      flash[:notice] = "Tenant admin user created successfully"
      redirect_to tenant_admin_tenant_admin_users_path
    else
      flash[:alert] = "There was an error creating new tanant admin user. Errors: #{@tenant_admin_user&.errors&.full_messages&.join(', ')}"
      render :new
    end
  end

  def update
    @tenant_admin_user = TenantAdminUser.find_by(id: params[:id])
    if @tenant_admin_user.update(tenant_admin_user_params)
      flash[:notice] = "Tenant admin user updated successfully."
      redirect_to tenant_admin_tenant_admin_users_path
    else
      flash.now[:alert] = "There was an error updating the tenant, errors: #{@tenant_admin_user&.errors&.full_messages&.join(', ')}"
  		render :new
    end
  end

  private

  def tenant_admin_user_params
    params.require(:tenant_admin_user).permit(
      :first_name, :last_name, :username, :email, :password, :confirm_password
    )
  end

end