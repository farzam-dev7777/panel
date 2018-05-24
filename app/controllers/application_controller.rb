class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_law_firm
  before_filter :authenticate_2fa

  def authenticate_2fa
    if current_user
      return true if request.original_url.include?('sign_out') || current_user.is_an_admin?
      unless session[:authorized]
        redirect_to new_two_factor_authentication_url unless request.original_url.include? 'two_factor_authentication/new'
      end
    else
      false
    end
  end

  def after_sign_in_path_for(resource)

    if ( current_user.role == 'superadmin' || current_user.role == 'admin' )
      admin_root_url
    else
    	new_two_factor_authentication_url
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

end
