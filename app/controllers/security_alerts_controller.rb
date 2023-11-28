class SecurityAlertsController < BaseController

  layout 'admin'

  def show
    @security_alert =  SecurityAlert.find(params[:id])
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

end
