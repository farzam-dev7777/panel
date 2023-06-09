class TenantAdmin::UsersController < TenantAdmin::BaseController
  layout 'tenant_admin'

  load_and_authorize_resource :user, except: [:create]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.order('created_at DESC')
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def create
    @user = User.new(tenant_admin_user_params)
    authorize! :create, @user
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

  def destroy
    @user = User.find_by(id: params[:id])
    if @user.destroy
      flash[:notice] = "User deleted successfully."
      redirect_to tenant_admin_users_path
    else
      flash.now[:alert] = "There was an error deleting the user, errors: #{@user&.errors&.full_messages&.join(', ')}"
      redirect_to edit_tenant_admin_user_path(@user)
    end
  end

  def reset_password_instructions
    user = User.find_by(id: params[:id])
    user.send_reset_password_instructions
    flash[:notice] = "User Password Reset email sent successfully."
    redirect_to tenant_admin_users_path
  end

  private

  def tenant_admin_user_params
    params.require(:user).permit(
      :first_name, :last_name, :username, :email, :password, :password_confirmation, :law_firm_id, :role
    )
  end

end