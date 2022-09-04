class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def okta
     @user = User.from_omniauth(request.env["omniauth.auth"])
      session[:oktastate] = request.env["omniauth.auth"]["uid"]
      if @user&.id.present?
        @user.reload
        sign_in @user
      end
     redirect_to root_path
  end
end