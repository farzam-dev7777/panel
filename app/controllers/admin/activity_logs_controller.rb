class Admin::ActivityLogsController < Admin::BaseController

  layout 'admin'

  def mark_as_read
  	notifications.unread.update_all(read: true)
  	head :ok
  end

  private

  def notifications
  	activities.notifications
  end

  def activities
		current_user.law_firm.activity_logs
  end

end
