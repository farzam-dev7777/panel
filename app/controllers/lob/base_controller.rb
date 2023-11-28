class Lob::BaseController < ApplicationController
  before_action :authenticate_user!, raise: false
  before_action :authenticate_lob!, raise: false

	layout 'lob'

	rescue_from CanCan::AccessDenied do |exception|
    redirect_back fallback_location: root_path, :alert => exception.message
  end

  def current_lob_user
    current_user
  end

  def authenticate_lob!
    redirect_to "/", :alert => "Access Denied!" if current_user.role != 'lob'
  end

end