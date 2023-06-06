class QueuedNotificationMailer < ApplicationMailer
	default from: email_address_with_name("support@secureengage.com", 'SEAL Support')
	layout 'mailer'

	def notify_law_firm(queued_notification)
		@queued_notification = queued_notification
		@law_firm = @queued_notification.action_item.law_firm
		mail(to: @law_firm.email, subject: queued_notification.trigger.message)
	end

end
