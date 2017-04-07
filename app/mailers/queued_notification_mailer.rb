class QueuedNotificationMailer < ApplicationMailer

	default from: "info@seal.grcconsulting.ca"

	def notify_law_firm(queued_notification)
		@queued_notification = queued_notification
		@law_firm = @queued_notification.action_item.law_firm
		mail(to: @law_firm.email, subject: queued_notification.trigger.message)
	end

end
