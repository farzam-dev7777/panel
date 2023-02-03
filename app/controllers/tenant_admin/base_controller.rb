class TenantAdmin::BaseController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_tenant_admin_tenant_admin_user!, raise: false

	layout 'tenant_admin'

	rescue_from CanCan::AccessDenied do |exception|
    if request.env["HTTP_REFERER"].blank?
      redirect_to tenant_admin_root_url, :alert => exception.message
    else
      redirect_to :back, :alert => exception.message
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs

    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

end