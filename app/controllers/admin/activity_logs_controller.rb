class Admin::ActivityLogsController < Admin::BaseController
# before_action :configure_sign_in_params, only: [:create]

  layout 'admin'

  def mark_as_read
  	notifications.update_all(read: true)
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
