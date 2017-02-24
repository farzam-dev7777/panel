class ActivityLog < ApplicationRecord
	belongs_to :loggable, polymorphic: true

	ACTION_OBJECT_TYPES = {
    account_created: User,
    certification_request: Request
  }.freeze

	def self.log(object)
		activity_log = ActivityLog.new(object)
		activity_log.save
	end
	
end
