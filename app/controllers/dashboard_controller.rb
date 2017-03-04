class DashboardController < BaseController

  def index
  	@security_alerts = SecurityAlert.all.paginate(page: params[:page])
  end
  
end
