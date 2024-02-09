class Proposal < ApplicationRecord
	belongs_to :rfp
	belongs_to :law_firm
	has_many :proposal_comments
	has_many :answers
	accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

end
