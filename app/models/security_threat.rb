class SecurityThreat < ApplicationRecord
	belongs_to 	:severity_level
	has_many 		:action_items

	def generate_action_items(law_firm_ids)
		ActionItem.create_action_items(self.id, law_firm_ids)
	end
end
