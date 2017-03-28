class TwoFactorAuthenticationController < ApplicationController

	layout false
  skip_before_filter :verify_authenticity_token

	def new
    if session[:authorized]
      redirect_to root_path
    end
  end

  def create
    if current_user.google_authentic? params[:code]
      session[:authorized] = true
      flash.now[:notice] = 'Authenitcation Successful.'
      redirect_to root_path
    else
      flash.now[:alert] = 'The code given does not match, please try again'
      render :new
    end
  end

end