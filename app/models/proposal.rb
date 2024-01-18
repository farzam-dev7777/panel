class Proposal < ApplicationRecord
	belongs_to :rfp
	belongs_to :law_firm
	has_many :proposal_comments
end
