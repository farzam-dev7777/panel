class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name("support@secureengage.com", 'SEAL Support')
  layout 'mailer'

end
