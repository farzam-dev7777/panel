class NotificationService

    def process(queued_notification)
      @queued_notification = queued_notification
      @action_item = @queued_notification.action_item
      @law_firm = @action_item.law_firm

      review_score
      log_queued_notification_sent     
    end

    def review_score
      return unless @law_firm
      @snf = queued_notification.severity_negative_factor || queued_notification.action_item.security_threat.severity_negative_factor
      # @law_firm.update_attributes(total_score: ) if snf > 0
      log_score_reviewed
    end

    def log_queued_notification_sent
      object = {
        law_firm_id: @action_item.law_firm_id,
        event_type: "#{@action_item.security_threat.severity_level.name}_security_alert",
        loggable: @queued_notification,
        custom_message: @queued_notification.trigger.message,
        notify: true
      }
      log_activity(object)
    end

    def log_score_reviewed
      object = {
        law_firm_id: @action_item.law_firm_id,
        event_type: "decrease_score",
        loggable: @queued_notification,
        custom_message: "Your score has been decreased in concern with the #{render_security_threat_link(@action_item)}",
        notify: true
      }
      log_activity(object)
    end

    def log_activity(object)
      activity_log = ActivityLog.log(object)
      send_email
    end

    def send_email
      if(@queued_notification.trigger.action_type == 'send_notification_to_law_firm')
        QueuedNotificationMailer.notify_law_firm(@queued_notification)
      end
    end

end