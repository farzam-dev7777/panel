class Users::PasswordsController < Devise::PasswordsController

  layout 'login'
  skip_before_action :verify_authenticity_token


  def update
    user = resource_class.with_deactivated.find_by(reset_password_token: params["user"]["reset_password_token"])
    if user
      user.password = params["user"]["password"]
      user.password_confirmation = params["user"]["password_confirmation"]
      if user && user.save
        redirect_to :root, notice: "Password updated, please login"
      else
        redirect_to :back, alert: "Password couldn't update, invalid password"
      end
    else
      redirect_to :back, alert: "Password couldn't update, invalid token"
    end
  end
end
