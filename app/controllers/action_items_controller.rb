class ActionItemsController < BaseController

	before_filter :find_action_item, only: [:mark_as_complete, :show]

  def mark_as_complete
  	@action_item.status = 'complete'
  	if @action_item.save
	  	queued_notifications = @action_item.queued_notifications.pending
	  	queued_notifications.update_all(deleted_at: Time.now)
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
  
end
