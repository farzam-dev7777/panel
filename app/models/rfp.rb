class Rfp < ApplicationRecord
	belongs_to :matter_intake
	has_many :rfp_invites
	has_many :proposals
	has_many :answers
	has_many :questions
	accepts_nested_attributes_for :matter_intake, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true

	attr_accessor :invites, :notify_lawyers
end
