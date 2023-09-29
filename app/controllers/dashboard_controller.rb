class DashboardController < BaseController

  before_action :check_new_password, only: :index

	def index
  	@action_items = []
  	# if current_user.is_a_standard_user?
	  	# if current_law_firm.profile_completed
	  	# redirect_to new_two_factor_authentication_path unless session[:authorized]
	  	#@security_alerts = SecurityAlert.all.paginate(page: params[:page]).order('created_at DESC')
			#@action_items = current_law_firm.action_items.decorate if current_law_firm.present?
			#@panel_request = PanelRequest.find_by_law_firm_id(current_law_firm.id)
		  # else
		  	# redirect_to edit_law_firm_path(current_law_firm)
		  # end
		# elsif current_user.is_an_admin?
		# 	redirect_to admin_root_url
		# else
		# 	root_url
		# end
		@matter_intakes_count = (current_user&.law_firm && current_user&.law_firm&.matter_intakes).count rescue 0
		@invoices_total = (current_user.law_firm&.matter_intakes&.map(&:invoices)&.flatten || []).map { |i| i.amount.to_f }.sum rescue 0
		@confilictc_requests_submitted = current_law_firm.conflict_waivers.order(created_at: :desc).count rescue 0
		@client_count = (current_law_firm&.tenants||[]).count
		@law_firm_tenant = current_law_firm&.law_firms_tenants&.where(tenant_id: Tenant&.current&.id)&.first
		if current_user.is_panel_admin_user?
			redirect_to admin_root_url
		end
  end

  def check_new_password
  	redirect_to set_new_password_path unless current_user.new_password_set
	end

	def docusign_callback
		userinfo = request.env['omniauth.auth']
		credentials = userinfo.credentials
    if credentials.token
			@settings = SystemSetting.fetch
      @settings.update_attributes(docusign_access_token: credentials.token, docusign_refresh_token: credentials.refresh_token, docusign_token_expires_at: Time.at(credentials.expires_at).to_datetime)
    end
    redirect_to admin_root_path
  end 
  
end
