class Admin::BaseController < ApplicationController
  before_action :authenticate_admin_admin_user!
	layout 'admin'

  def current_admin_user
    current_admin_admin_user
  end

end