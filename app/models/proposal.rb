class Proposal < ApplicationRecord
	belongs_to :rfp
	belongs_to :law_firm
	belongs_to :created_by, class_name: 'User', optional: true
	belongs_to :updated_by, class_name: 'User', optional: true
	has_many :proposal_comments
	has_many :answers
	accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

	def show_status
		if status == 'pending'
			'Submitted'
		else
			status
		end
	end
end
