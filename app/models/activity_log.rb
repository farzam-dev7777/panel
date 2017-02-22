class ActivityLog < ApplicationRecord
	belongs_to :loggable, polymorphic: true

	scope :notifications,  -> { where(notify: true) }

	ACTION_TYPE_REASON = {
    account_created: 'Firm\'s account was created'
  }.freeze

	def self.log(object)
		activity_log = ActivityLog.new(object)
		object = object.merge(custom_reason: ACTION_TYPE_REASON[object[:event_type].to_sym]) unless object[:custom_reason]
		activity_log.save
	end
end
