class TwoFactorAuthenticationController < ApplicationController

	layout false
  skip_before_filter :verify_authenticity_token

	def new
    session[:authorized] = true
    if session[:authorized]
      redirect_to root_path
    end
  end

  def create
    if current_user.google_authentic? params[:code]
      session[:authorized] = true
      flash.now[:notice] = 'Authentication Successful.'
      if current_user.role == 'master_user' && current_user.sign_in_count == 1
        redirect_to law_firm_edit_path(current_law_firm)
      else
        redirect_to root_path
      end
    else
      flash.now[:alert] = 'The code given does not match, please try again'
      render :new
    end
  end

end