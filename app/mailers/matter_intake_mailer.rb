class MatterIntakeMailer < ApplicationMailer
  default from: "info@panel.grcx.io"
  layout 'mailer'

  def send_notification_to_lawyer_for_form_submission(matter_intake)
    @matter_intake = matter_intake
    mail(to: @matter_intake.lawyer.email, subject: "New Matter Intake Created")
  end

  def send_notification_to_lxp_for_form_submission(matter_intake)
    @matter_intake = matter_intake
    @lxp_users = User.where(role: 'lxp')
    @lxp_users.each do |lxp|
      mail(to: lxp.email, subject: "Matter Intakes form has been submitted") if lxp.email.present?
    end
  end

end