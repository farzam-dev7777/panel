class TodoTask < ApplicationRecord

	scope :critical,  -> { where("severity = 'critical'") }
	scope :not_critical,  -> { where("severity != 'critical'") }

	after_save :log_activity

	def log_activity
		object = {
  		law_firm_id: self.law_firm_id,
  		event_type: 'todo_task_created',
  		loggable: self.send(ActivityLog::ACTION_OBJECT_TYPES[:todo_task_created].to_s.downcase.to_sym),
      notify: true
  	}
  	ActivityLog.log(object)
	end

end
