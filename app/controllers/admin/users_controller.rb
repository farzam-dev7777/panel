class Admin::UsersController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Dashboard", :root_path

  def index 
    @q = User.ransack(params[:q])
    @users = @q.result.where(role: User::PANEL_ADMIN_USER_ROLES).order('created_at DESC')
  end

  def show
    
  end

  def create
    @user = User.new(users_params)
    @user.tenant_id = Tenant.current&.id || nil
    if @user.save
      flash[:notice] = "New User Added"
      redirect_to :admin_users
    else
      flash[:alert] = "There was an error submiting the new user."
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(users_params)
      flash[:notice] = "User updated"
      redirect_to admin_users_path(@exception_request)
    else
      flash[:alert] = "There was an error updating the user"
      render :new
    end
  end

   
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end
 
  def edit_profile
    @user = User.find(params[:id])
  end

  def update_profile
    @user = User.find(params[:id])
    if @user.update_attributes(users_params)
      flash[:notice] = "User updated"
      render :edit_profile, :id => @user.id
    else
      flash[:alert] = "There was an error updating the user"
      render :edit_profile, :id => @user.id
    end
  end

  def send_user_info
    @user = User.with_deactivated.find_by(id: params[:id])
    if @user
      @user.activate!
      @user.send_user_info_with_password
      head :ok
    end
  end

  def send_user_info_with_certification
    @user = User.with_deactivated.find_by(id: params[:id])
    if @user
      @user.activate!
      @law_firm = @user.law_firm
      if @law_firm.present?
        FormSubmission.generate_initial_submissions(@law_firm, @user)
      end
      @user.send_user_info_with_rfi
      head :ok
    end
  end


  private

  def users_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :username, :password, 
      :password_confirmation, :send_password_reset_link, :role, :lob_contact_name, :line_of_business,
      :reset_password_token
    )

  end

end
