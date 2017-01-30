class ActivityLog < ApplicationRecord
	belongs_to :loggable, polymorphic: true

	def self.log(object)
		activity_log = ActivityLog.new(object)
		activity_log.save
	end
end
