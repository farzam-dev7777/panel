class Admin::BaseController < ApplicationController
  before_action :authenticate_user!, raise: false
	layout 'admin'

	rescue_from CanCan::AccessDenied do |exception|
    redirect_to :back, :alert => exception.message
  end

  def current_admin_user
    current_user
  end

end