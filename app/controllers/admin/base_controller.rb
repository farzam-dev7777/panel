class Admin::BaseController < ApplicationController
  before_action :authenticate_user!, raise: false
  before_action :authenticate_admin!, raise: false

	layout 'admin'

	rescue_from CanCan::AccessDenied do |exception|
    if request.env["HTTP_REFERER"].blank?
      redirect_to admin_root_url, :alert => exception.message
    else
      redirect_to :back, :alert => exception.message
    end
  end

  def current_admin_user
    current_user
  end

  def authenticate_admin!
    redirect_to "/", :alert => "Access Denied!" if current_user.role != 'superadmin' && !current_user.is_panel_admin_user?
  end

end