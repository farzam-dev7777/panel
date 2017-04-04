class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_law_firm

  def after_sign_in_path_for(resource)
    if (current_user.class.to_s == 'User')
    	new_two_factor_authentication_url
    else
    	super
    end
  end

  def current_law_firm
		current_user.law_firm
  end

end
