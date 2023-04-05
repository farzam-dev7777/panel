class TenantAdmin::UsersController < TenantAdmin::BaseController
  layout 'tenant_admin'

  def index
    @q = User.ransack(params[:q])
    @tenant_admins = @q.result.where(role: User::TENANT_ADMIN_USER_ROLES).order('created_at DESC')
  end

  def new
    @tenant_admin_user = User.new
  end

  def edit
    @tenant_admin_user = User.find_by(id: params[:id])
  end

  def create
    @tenant_admin_user = User.new(tenant_admin_user_params)
    @tenant_admin_user.role = "tenant_admin"
    if @tenant_admin_user.save
      flash[:notice] = "Tenant admin user created successfully"
      redirect_to tenant_admin_users_path
    else
      flash[:alert] = "There was an error creating new tanant admin user. Errors: #{@tenant_admin_user&.errors&.full_messages&.join(', ')}"
      render :new
    end
  end

  def update
    @tenant_admin_user = User.find_by(id: params[:id])
    if @tenant_admin_user.update(tenant_admin_user_params)
      flash[:notice] = "Tenant admin user updated successfully."
      redirect_to tenant_admin_users_path
    else
      flash.now[:alert] = "There was an error updating the tenant, errors: #{@tenant_admin_user&.errors&.full_messages&.join(', ')}"
  		render :new
    end
  end

  private

  def tenant_admin_user_params
    params.require(:user).permit(
      :first_name, :last_name, :username, :email, :password, :password_confirmation
    )
  end

end