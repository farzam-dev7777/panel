class DashboardController < BaseController

  def index
  	@security_alerts = SecurityAlert.all.paginate(page: params[:page])
  	@action_items = current_law_firm.action_items.decorate
  end
  
end
