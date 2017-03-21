class SecurityThreat < ApplicationRecord
	belongs_to 	:severity_level
	has_many 		:action_items

	def generate_action_items(params, current_user)
		ActionItem.create_action_items(self.id, params, current_user)
	end
end
