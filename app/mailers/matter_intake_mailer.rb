class MatterIntakeMailer < ApplicationMailer
  default from: "info@panel.grcx.io"
  layout 'mailer'

  def send_notification_to_lawyer_for_form_submission(matter_intake)
    @matter_intake = matter_intake
    mail(to: @matter_intake.lawyer.email, subject: "New matter intake form has been submitted")
  end

  def send_notification_to_lxp_for_form_submission(matter_intake)
    @matter_intake = matter_intake
    @lxp_users = User.where(role: 'lxp')
    @lxp_users.each do |lxp|
      mail(to: lxp.email, subject: "Matter intake form has been submitted") if lxp.email.present?
    end
  end

  def send_notification_litigation_specialist_team(matter_intake)
    @matter_intake = matter_intake
    mail(to: ["manpreet@metawarelabs.com"], bcc: ["sandeep@metawarelabs.com"], subject: "Matter intake (Litigation Specialist Team) - New insurance claim submitted")
  end

  def send_notification_to_lawyer_for_matter_open(matter_intake)
    @matter_intake = matter_intake
    # Sending email to lawyer
    if @matter_intake.lawyer.present? && @matter_intake.lawyer.email.present?
      mail(to: @matter_intake.lawyer.email, subject: "Matter intake case has been opened in T360")
    end
  end

  def send_notification_to_lxp_for_matter_open(matter_intake)
    @matter_intake = matter_intake
    # Sending email to lob
    if @matter_intake.user_id.present? && @matter_intake.user.email.present?
      mail(to: @matter_intake.user.email, subject: "New matter intake case has been opened in T360")
    end
  end

  def send_notification_to_lawyer_form_needs_updation(matter_intake)
    @matter_intake = matter_intake

    if @matter_intake.lawyer.present? && @matter_intake.lawyer.email.present?
      mail(to: @matter_intake.lawyer.email, subject: "Matter intake form needs an update")
    end
  end

end