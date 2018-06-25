class SecurityAlertsController < BaseController

  layout 'admin'

  def show
    @security_alert =  SecurityAlert.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

end
