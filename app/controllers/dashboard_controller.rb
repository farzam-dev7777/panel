class DashboardController < BaseController

  def index
  	logs = current_user.try(:law_firm).activity_logs
  	notifications = logs.notifications
  	render locals: {
  		activities: logs,
  		notifications: notifications.decorate,
  		unread_notifications_count: notifications.pluck(:read).count(nil)
  	}
  end
  
end
