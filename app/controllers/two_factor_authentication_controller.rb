class TwoFactorAuthenticationController < ApplicationController

	layout false
  skip_before_filter :verify_authenticity_token

	def new
    if session[:authorized]
      redirect_to root_path
    else
      current_user.set_google_secret
    end
  end

  def create
    if current_user.google_authentic? params[:code]
      session[:authorized] = true 
      redirect_to root_path
    else
      flash.now[:error] = 'The code given does not match, please try again'
      render :new
    end
  end

end