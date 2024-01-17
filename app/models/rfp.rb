class Rfp < ApplicationRecord
	belongs_to :matter_intake
	has_many :rfp_invites
	accepts_nested_attributes_for :matter_intake, reject_if: :all_blank, allow_destroy: true

	attr_accessor :invites
end
