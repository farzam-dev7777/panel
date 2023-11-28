class TenantAdmin::BaseController < ApplicationController
  before_action :authenticate_user!, raise: false
  before_action :authenticate_tenant_admin!, raise: false

	layout 'tenant_admin'

	rescue_from CanCan::AccessDenied do |exception|
    if request.env["HTTP_REFERER"].blank?
      redirect_to root_url, :alert => exception.message
    else
      redirect_back fallback_location: root_path, :alert => exception.message
    end
  end

  def authenticate_tenant_admin!
    if current_user.role === "lob"
      redirect_to "/lob", :alert => "" if current_user.role == 'lob'
    elsif current_user.role === "lxp" || current_user.role === "internal_lawyers"
      redirect_to "/admin", :alert => "" if current_user.role == 'internal_lawyers'
    else
      redirect_to "/", :alert => "Access Denied!" if current_user.role != 'tenant_admin' 
    end
  end

end