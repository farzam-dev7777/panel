class QueuedNotification < ApplicationRecord
	acts_as_paranoid
	belongs_to :trigger
	belongs_to :action_item

	scope :pending,  -> { where(triggered: false) }
	# default_scope { where("deleted_at IS NULL") }

	def self.generate_notifications(action_item, params, current_user)
		triggers = action_item.security_threat.severity_level.triggers
		triggers.each_with_index do |trigger, i|
			q = QueuedNotification.new(trigger_at: trigger.hours.hours.from_now, 
																 trigger_id: trigger.id, 
																 action_item_id: action_item.id)
																 # severity_negative_factor: params[:snf]["snf_#{i}"])
			q.save
		end

		object = {
	    law_firm_id: action_item.law_firm_id,
	    event_type: "#{action_item.security_threat.severity_level.name}_security_alert",
	    loggable: action_item,
	    custom_message: action_item.security_threat.title,
	    notify: true,
	    source: current_user.class,
	    email: current_user.email
	  }
	  ActivityLog.log(object)
	end

	def self.send_notifications
		@q = QueuedNotification.where("trigger_at >= ?", Time.zone.now.beginning_of_day)
		@q.each do |q|
			begin
				NotificationService.process(q)
			rescue
			end
		end
	end

end
