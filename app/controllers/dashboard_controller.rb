class DashboardController < BaseController

  def index
  	# if current_law_firm.profile_completed
  	redirect_to new_two_factor_authentication_path unless session[:authorized]
  	@security_alerts = SecurityAlert.all.paginate(page: params[:page]).order('created_at DESC')
  	@action_items = current_law_firm.action_items.decorate
	  # else
	  	# redirect_to edit_law_firm_path(current_law_firm)
	  # end
  end
  
end
