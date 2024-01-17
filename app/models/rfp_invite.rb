class RfpInvite < ApplicationRecord
	belongs_to :rfp
	belongs_to :law_firm
	belongs_to :user, optional: true
end
