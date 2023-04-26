class UserMailer < ApplicationMailer
  default from: "support@secureengage.com"
  layout 'mailer'

  def send_password_reset_link(user)
    @user = user
    mail(to: @user.email, subject: "New User Created - Reset Password Link")
  end

  def send_user_info_with_password(user)
    @user = user
    mail(to: @user.email, subject: "Reset Password Link")
  end

  def send_user_info_with_password_with_rif(user)
    @user = user
    mail(to: @user.email, subject: "Reset Password Link and begin RFI")
  end

  def send_two_fa(user)
    @user = user
    mail(to: @user.email, subject: "One Time Password - 2 Factor Authentication")
  end
  
end
