class LawFirmMailer < ApplicationMailer
  default from: 'from@example.com'

  def account_creation_confirmation(law_firm)
  	@law_firm = law_firm
  	mail(to: law_firm.email, subject: "Your account has been successfully created")
  end
end
