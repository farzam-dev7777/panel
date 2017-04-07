class AdminMailer < ApplicationMailer
  default from: 'from@example.com'
  
  ADMIN_EMAIL = 'gagan@metawarelabs.com'

  def forms_submitted(form_submission)
  	@law_firm = form_submission.law_firm
  	mail(to: ADMIN_EMAIL, subject: "#{@law_firm.name} have submitted the forms")
  end

  def submission_expired(form_submission)
  	@law_firm = form_submission.law_firm
    mail(to: ADMIN_EMAIL, subject: "#{@law_firm.name}'s latest form submission has expired. Please take action")
  end

  def score_below_threshold(law_firm)
    @law_firm = law_firm
  	mail(to: ADMIN_EMAIL, subject: "#{@law_firm.name}'s score has gone below system's threshold.")
  end

end
