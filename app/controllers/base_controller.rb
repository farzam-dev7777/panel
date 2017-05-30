class BaseController < ApplicationController
  # include CanCan::ControllerAdditions
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!

  helper_method :current_law_firm, :activities, :notifications, :unread_notifications_count

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def activities
		@logs ||= current_law_firm.activity_logs
  end

  def notifications
		@notifications ||= activities.notifications.decorate
  end

  def unread_notifications_count
		@unread_notifications_count = notifications.pluck(:read).count(nil)
  end

end