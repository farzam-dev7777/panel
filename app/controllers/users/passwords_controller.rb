class Users::PasswordsController < Devise::PasswordsController

  layout 'login'
  skip_before_filter :verify_authenticity_token

end
