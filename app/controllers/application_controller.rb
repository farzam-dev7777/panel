class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_law_firm
  before_action :set_current_user
  before_action :authenticate_2fa

  #before_filter :set_cache_headers
  before_action :set_tenant
  before_action :set_locale
  before_action :matter_tracking

  #before_action :set_cache_headers

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def set_current_user
    Current.user ||= current_user
  end

  def authenticate_2fa
    return false
    return false if (params[:controller] == 'users/sessions' && params[:action] == 'create') || ENV['DISABLE_2FA'].present?
    if (current_user) && ( current_user.role == 'superadmin' || current_user.role == 'admin' || current_user.is_panel_admin_user? ) && request.env.fetch("PATH_INFO") == "/"
      if current_user.role == "lob"
        redirect_to lob_root_url
      else
        redirect_to admin_root_url
      end
      
    end

    if current_user
      return true if request.original_url.include?('sign_out') || current_user.is_an_admin? 
      unless session[:authorized]
        current_user.send_two_fa
        redirect_to new_two_factor_authentication_url unless request.original_url.include? 'two_factor_authentication/new'
      end
    else
      false
    end
  end

  def after_sign_in_path_for(resource)
    Current.user = resource
    # resource&.send_two_fa
    if Current.user&.role === "tenant_admin"
      Apartment::Tenant.switch!('public')
      tenant_admin_root_url(subdomain: 'panel')
    elsif Current.user&.role === "master_user"
      switch_to_master_user_tenant
      root_path
    else
      tenant = Tenant.find_by(subdomain: fetch_subdomain)
      Apartment::Tenant.switch!(tenant&.subdomain || 'public')
      if ( current_user.role == 'superadmin' || current_user.role == 'admin' || current_user.is_panel_admin_user? )
        if current_user.role == "lob"
          current_user.tenant.present? ? lob_root_url(subdomain: current_user.tenant&.subdomain) : lob_root_url
        else
          current_user.tenant.present? ? admin_root_url(subdomain: current_user.tenant&.subdomain) : admin_root_url
        end
      else
        root_path
        # current_user.send_two_fa
        # new_two_factor_authentication_url
      end
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    session.delete(:authorized)
    super
  end

  def current_law_firm
    return nil unless current_user.is_a_standard_user?
		current_user.law_firm
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def matter_tracking
    unless(params[:action] == 'show' && (["lob/matter_intakes", "admin/matter_intakes", "matter_intakes"].include?(params[:controller])) && cookies[:matter_open].present?)
      if cookies[:matter_open].present?
        matter_data = JSON.parse cookies[:matter_open]||{}
        matter_intake = MatterIntake.find_by_id matter_data['matter_intake_id']
        if matter_intake.present?
          time_difference = TimeDifference.between(matter_data['time'].to_datetime, Time.now).humanize
          matter_intake.versions.new(message: "Matter viewed for #{time_difference}", event: 'view', whodunnit: current_user.full_name).save        
        end
        cookies[:matter_open] = nil
      end
    end
  end

  protected

  def switch_to_master_user_tenant
    if Current.user&.role === "master_user"
      if Tenant.current.nil?
        if Current.user&.tenant.present?
          tenant = Current.user&.tenant
        else
          tenant = Current.user&.law_firm&.tenants&.first
        end
        Apartment::Tenant.switch!(tenant&.subdomain)
      end
    else
      Apartment::Tenant.switch!('public')
    end
  end

  def set_tenant
    if !fetch_subdomain.blank?
      tenant = Tenant.find_by(subdomain: fetch_subdomain)
      if tenant.present?
        if ["lob", "lxp", "internal_lawyers"].include?(Current.user&.role)
          if Current.user.tenant.present? && Current.user.tenant&.subdomain != tenant&.subdomain
            Apartment::Tenant.switch!(Current.user.tenant&.subdomain)
          else
            Apartment::Tenant.switch!(tenant&.subdomain)
          end
        else
          Apartment::Tenant.switch!(tenant&.subdomain)
        end
      else
        switch_to_master_user_tenant
      end
    else
      switch_to_master_user_tenant
    end
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def fetch_subdomain
    request.subdomain
  end

end
