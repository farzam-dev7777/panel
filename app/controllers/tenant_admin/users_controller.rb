class TenantAdmin::UsersController < TenantAdmin::BaseController
  layout 'tenant_admin'

  load_and_authorize_resource :class => "User"

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.order('created_at DESC')
  end

  def new
    @users = User.new
  end

  def edit
    @users = User.find_by(id: params[:id])
  end

  def create
    @user = User.new(tenant_admin_user_params)
    @user.role = "tenant_admin"
    if @user.save
      flash[:notice] = "User created successfully"
      redirect_to tenant_admin_users_path
    else
      flash[:alert] = "There was an error creating new tanant admin user. Errors: #{@user&.errors&.full_messages&.join(', ')}"
      render :new
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(tenant_admin_user_params)
      flash[:notice] = "User updated successfully."
      redirect_to tenant_admin_users_path
    else
      flash.now[:alert] = "There was an error updating the user, errors: #{@user&.errors&.full_messages&.join(', ')}"
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