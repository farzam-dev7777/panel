class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_law_firm

  def after_sign_in_path_for(resource)

    if ( current_user.role == 'superadmin' || current_user.role == 'admin' )
    	# new_two_factor_authentication_url
      admin_root_url
    # elsif ( current_user.role == 'user' )
    #   binding.pry
    #   root_url
    else
      # unknown user role
    	super
    end
  end

  def current_law_firm
    return nil unless current_user.is_a_standard_user?
		current_user.law_firm
  end

end
