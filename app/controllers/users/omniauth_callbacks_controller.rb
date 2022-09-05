class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def okta
    @user = User.from_omniauth(request.env["omniauth.auth"])
    session[:oktastate] = request.env["omniauth.auth"]["uid"]
    if @user&.id.present?
      @user.reload
      sign_in @user
      redirect_to root_path
    else
      flash[:notice] = "Error authenticating! Please ensure user have permission to access."
      redirect_to new_user_session_path
    end
  end
end