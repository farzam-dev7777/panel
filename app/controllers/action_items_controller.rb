class ActionItemsController < BaseController

	before_action :find_action_item, only: [:mark_as_complete, :show]

  def mark_as_complete
  	@action_item.status = 'complete'
  	if @action_item.save
	  	queued_notifications = @action_item.queued_notifications.pending
	  	queued_notifications.update_all(deleted_at: Time.now)
      log_completion
  	end
  	head :ok
  end

  def show
    @security_threat = @action_item.security_threat
    respond_to do |format|
      format.js
    end
  end

  private

  def find_action_item
  	@action_item = ActionItem.find(params[:id])
  end

  def log_completion
    object = {
      law_firm_id: @action_item.law_firm_id,
      event_type: 'action_item_marked_as_complete',
      loggable: @action_item,
      notify: false,
      source: current_user.class,
      email: current_user.email
    }
    ActivityLog.log(object)
  end
  
end
