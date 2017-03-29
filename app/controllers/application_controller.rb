class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    if (current_user.class.to_s == 'User')
    	new_two_factor_authentication_url
    else
    	super
    end
  end

end
