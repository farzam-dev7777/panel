class DashboardController < BaseController

  def index
  	redirect_to new_two_factor_authentication_path unless session[:authorized]
  	@security_alerts = SecurityAlert.all.paginate(page: params[:page])
  	@action_items = current_law_firm.action_items.decorate
  end
  
end
