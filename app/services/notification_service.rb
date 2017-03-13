class NotificationService

    def process(queued_notification)
        @queued_notification = queued_notification
        @action_item = @queued_notification.action_item

        object = {
          law_firm_id: @action_item.law_firm_id,
          event_type: "#{@action_item.security_threat.severity_level.name}_security_alert",
          loggable: @queued_notification,
          custom_message: @queued_notification.trigger.message,
          notify: true
        }

        activity_log = ActivityLog.log(object)
        send_email
    end

    private

    def send_email
      if(@queued_notification.trigger.action_type == 'send_notification_to_law_firm')
        QueuedNotificationMailer.notify_law_firm(@queued_notification)
      end
    end

end