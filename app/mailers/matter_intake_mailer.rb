class MatterIntakeMailer < ApplicationMailer
  default from: "SEAL Support <support@secureengage.com>"
  layout 'mailer'

  def send_notification_to_lawyer_for_form_submission(matter_intake, emails = [])
    @matter_intake = matter_intake
    if emails.blank?
      to_email = @matter_intake.lawyer.present? ? [@matter_intake.lawyer.email] : []
      to_email << @matter_intake.reviewer_email if @matter_intake.reviewer_email.present?
    else
      @law_firm = true
      to_email = emails
    end
    if to_email.present?
      mail(to: to_email, subject: "New matter intake form has been submitted")
    end
  end

  def send_notification_to_lxp_for_form_submission(matter_intake)
    @matter_intake = matter_intake
    @lxp_users = User.where(role: 'lxp', tenant_id: Tenant.current.id)
    @lxp_users.each do |lxp|
      mail(to: lxp.email, subject: "Matter intake form has been submitted") if lxp.email.present?
    end
  end

  def send_notification_litigation_specialist_team(matter_intake)
    @matter_intake = matter_intake
    mail(to: ["manpreet@grcconsulting.ca"], subject: "Matter intake (Litigation Specialist Team) - New insurance claim submitted")
  end

  def send_notification_to_lawyer_for_matter_open(matter_intake)
    @matter_intake = matter_intake
    # Sending email to lawyer
    if @matter_intake.lawyer.present? && @matter_intake.lawyer.email.present?
      mail(to: @matter_intake.lawyer.email, subject: "Matter intake status changed.")
    end
  end

  def send_notification_to_lxp_for_matter_open(matter_intake)
    @matter_intake = matter_intake
    # Sending email to lob
    if @matter_intake.user_id.present? && @matter_intake.user.email.present?
      mail(to: @matter_intake.user.email, subject: "Matter intake status changed.")
    end
  end

  def send_notification_to_lawyer_form_needs_updation(matter_intake)
    @matter_intake = matter_intake

    if @matter_intake.lawyer.present? && @matter_intake.lawyer.email.present?
      mail(to: @matter_intake.lawyer.email, subject: "Matter intake form needs an update")
    end
  end

  def send_notification_to_law_firm_for_matter_open(matter_intake)
    @matter_intake = matter_intake
    if @matter_intake.law_firm.present? && @matter_intake.law_firm.email.present?
      mail(to: @matter_intake.law_firm.email, subject: "Matter intake form has been submitted")
    end
  end
end