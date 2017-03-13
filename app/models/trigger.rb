class Trigger < ApplicationRecord
	has_many :queued_notifications
	belongs_to :severity_level
end
