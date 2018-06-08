class TwoFactorAuthenticationController < ApplicationController

	layout false
  skip_before_filter :verify_authenticity_token, :authenticate_2fa

	def new
    # session[:authorized] = true if Rails.env == 'development'
    if session[:authorized]
      navigate_user
    end
  end

  def create
    if current_user.google_authentic? params[:code]
      session[:authorized] = true
      flash.now[:notice] = 'Authentication Successful.'
      navigate_user
    else
      flash.now[:alert] = 'The code given does not match, please try again'
      render :new
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