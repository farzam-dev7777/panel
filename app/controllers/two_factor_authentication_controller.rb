class TwoFactorAuthenticationController < ApplicationController

	layout false
  skip_before_filter :verify_authenticity_token, :authenticate_2fa

  after_action :track_google_auth

	def new
    session[:authorized] = true if Rails.env == 'development'
    redirect_to root_path if current_user.nil?
    if session[:authorized]
      navigate_user
    end
  end

  def create
    if current_user.google_authentic? params[:code]
      session[:authorized] = true
      # current_user.update_attributes({ qr_code_confirmed_at: Time.now })
      flash.now[:notice] = 'Authentication Successful.'
      navigate_user
    else
      flash.now[:alert] = 'The code given does not match, please try again'
      render :new
    end
  end

  def track_google_auth
    if session[:authorized]
      begin
        $tracker.people.increment(current_law_firm && current_law_firm.name, {
          'GoogleAuth' => 1
        })
        $tracker.track(current_law_firm && current_law_firm.name, 'GoogleAuth', {
          'username' => current_user.username
        })
      rescue Exception => e
        Rollbar.log('error', e)
      end
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