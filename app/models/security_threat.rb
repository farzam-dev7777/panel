class SecurityThreat < ApplicationRecord
	belongs_to 	:severity_level
	has_many 		:action_items

	attr_accessor :law_firm_ids

	validate :check_law_firm_ids

	def generate_action_items(params, current_user)
		if params[:law_firm_ids].nil?
			errors.add(:law_firm_ids, "You must select law firm ids")
			return
		else
			ActionItem.create_action_items(self.id, params, current_user)
		end
	end

	def check_law_firm_ids
		errors.add(:law_firm_ids, "must be present") if self.law_firm_ids.nil?
	end

	def generate_pending_action_items_after_approval(law_firm_id, current_user)
		action_item = ActionItem.new(security_threat_id: self.id, law_firm_id: law_firm_id)
		if action_item.save
      QueuedNotification.generate_notifications(action_item, nil, current_user)
      LawFirmMailer.security_threat_generated(law_firm_id).deliver_now
		end
	end

end
