every 1.day, :at => '4:30 am' do
  runner "QueuedNotification.send_notifications"
  runner "FormSubmission.check_for_expiry"
end

every 6.hours do
  rake "rake docusign:refresh_token"
end