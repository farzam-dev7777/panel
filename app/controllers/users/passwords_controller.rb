class Users::PasswordsController < Devise::PasswordsController

  layout 'login'
  before_action :verify_format, only: [:new]
  skip_before_action :verify_authenticity_token

  def create
    self.resource = User.find_by_email resource_params['email']
    if self.resource.blank?
      redirect_back fallback_location: root_path, alert: "Email not found"
    else
      self.resource.send_reset_password_instructions
      if successfully_sent?(resource)
        respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
      else
        respond_with(resource)
      end
    end
  end

  def update
    user = resource_class.with_deactivated.find_by(reset_password_token: params["user"]["reset_password_token"])
    
    if user
      user.password = params["user"]["password"]
      user.password_confirmation = params["user"]["password_confirmation"]
      # this is done to bypass set new password page related to 2 Factor auth
      user.new_password_set = true
      if user && user.save
        redirect_to :root, notice: "Password updated, please login"
      else
        redirect_back fallback_location: root_path, alert: "Password couldn't update, invalid password"
      end
    else
      redirect_back fallback_location: root_path, alert: "Password couldn't update, invalid token"
    end
  end

  def verify_format
    if params['format'].present?
     raise ActionController::RoutingError.new('Not Found')
    end
  end
end
