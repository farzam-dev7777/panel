class SecurityAlertsController < BaseController

  layout 'admin'

  def show
    @security_alert =  SecurityAlert.find(params[:id])
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

end
