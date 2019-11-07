class Lob::UsersController < Lob::BaseController

  layout 'lob'

  add_breadcrumb "Dashboard", :root_path

 
  
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

  private

  def users_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :username, :password, :password_confirmation, :role, :lob_contact_name, :line_of_business
    )

  end

end
