class TwoFactorAuthenticationController < ApplicationController

	layout false
  skip_before_action :verify_authenticity_token

  # after_action :track_google_auth

	def new
    redirect_to root_path if current_user.nil?
    if session[:authorized]
      navigate_user
    end
  end

  def create
    # if current_user.authentic_email_two_factor?(params[:code])
      session[:authorized] = true
      # flash.now[:notice] = 'Authentication Successful.'
      navigate_user
    # else
    #   flash.now[:alert] = 'The code given does not match or expired, please try again'
    #   render :new
    # end
  end

  def send_two_factor_auth_again
    if current_user.send_two_fa
      redirect_to new_two_factor_authentication_url, notice: "Check your email for authentication code"
    else
      redirect_to new_two_factor_authentication_url, notice: "Couldn't send the code to your email"
    end
  end

  private

  def navigate_user
    if !current_user.new_password_set
      redirect_to set_new_password_path
    else
      redirect_to root_path
    end
  end

end