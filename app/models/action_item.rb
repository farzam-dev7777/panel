class ActionItem < ApplicationRecord
	has_many :queued_notifications
	belongs_to :security_threat
	belongs_to :law_firm

	scope :complete, -> { where(status: 'complete') }

	def self.create_action_items(security_threat_id, law_firm_ids)
		law_firm_ids.each do |id|
			action_item = ActionItem.new(security_threat_id: security_threat_id, law_firm_id: id)
			QueuedNotification.generate_notifications(action_item) if action_item.save
		end
	end
end
