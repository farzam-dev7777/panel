class DashboardController < BaseController

  before_action :check_new_password, only: :index

  def index
  	@action_items = []
  	# if current_user.is_a_standard_user?
	  	# if current_law_firm.profile_completed
	  	redirect_to new_two_factor_authentication_path unless session[:authorized]
	  	@security_alerts = SecurityAlert.all.paginate(page: params[:page]).order('created_at DESC')
			@action_items = current_law_firm.action_items.decorate if current_law_firm.present?
			@panel_request = PanelRequest.find_by_law_firm_id(current_law_firm.id)
		  # else
		  	# redirect_to edit_law_firm_path(current_law_firm)
		  # end
		# elsif current_user.is_an_admin?
		# 	redirect_to admin_root_url
		# else
		# 	root_url
		# end
  end

  def check_new_password
  	redirect_to set_new_password_path unless current_user.new_password_set
  end
  
end
