class Users::PasswordsController < Devise::PasswordsController

  layout 'login'
  skip_before_action :verify_authenticity_token

end
