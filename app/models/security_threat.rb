class SecurityThreat < ApplicationRecord
	belongs_to 	:severity_level
	has_many 		:action_items

	def generate_action_items(params)
		ActionItem.create_action_items(self.id, params)
	end
end
