class UserMailer < ApplicationMailer
  default from: "info@panel.grcx.io"
  layout 'mailer'

  def send_password_reset_link(user)
    @user = user
    mail(to: @user.email, subject: "New User Created - Reset Password Link")
  end
  
end
