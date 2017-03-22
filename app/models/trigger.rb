class Trigger < ApplicationRecord
	has_many :queued_notifications
	belongs_to :severity_level

	ACTION_TYPES = ['send_notification_to_law_firm', 'send_notification_to_bank'].freeze
end
