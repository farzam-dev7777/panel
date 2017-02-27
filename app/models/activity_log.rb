class ActivityLog < ApplicationRecord
	belongs_to :loggable, polymorphic: true

	scope :notifications,  -> { where(notify: true) }
	scope :unread,  -> { where("notify = ? AND read != ?", true, true) }
	scope :read,  -> { where("notify = ? AND read = ?", true, true) }

	ACTION_OBJECT_TYPES = {
    account_created: User,
    todo_task_created: TodoTask
	}

	ACTION_TYPE_REASON = {
    account_created: 'Firm\'s account was created',
    todo_task_created: 'A Todo task was created'
  }.freeze

	def self.log(object)
		activity_log = ActivityLog.new(object)
		object = object.merge(custom_reason: ACTION_TYPE_REASON[object[:event_type].to_sym]) unless object[:custom_reason]
		activity_log.save
	end
	
end
