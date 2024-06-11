class Rfp < ApplicationRecord
	belongs_to :matter_intake
	has_many :rfp_invites
	has_many :proposals
	has_many :answers
	has_many :questions
	has_many :rfp_lobs
	accepts_nested_attributes_for :matter_intake, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :rfp_lobs, reject_if: :all_blank, allow_destroy: true


	attr_accessor :invites, :notify_lawyers


	def can_edit?(user)
		return false if user.blank?
		if user.role == 'lob'
			self.rfp_lobs.where(user_id: user.id, role: ['Contributor']).present?
		elsif user.role == 'lxp' || user.role == 'tenant_admin'
			true
		else
			false
		end
	end

	def can_read?(user)
		return false if user.blank?
		if user.role == 'lob'
			self.rfp_lobs.where(user_id: user.id, role: ['Contributor', 'Vote only', 'Read only']).present?
		elsif user.role == 'lxp' || user.role == 'tenant_admin'
			true
		else
			false
		end
	end

	def can_vote?(user)
		return false if user.blank?
		if user.role == 'lob'
			self.rfp_lobs.where(user_id: user.id, role: ['Contributor', 'Vote only']).present?
		elsif user.role == 'lxp' || user.role == 'tenant_admin'
			true
		else
			false
		end
	end

	def show_status
		self.status == 'pending' ? 'open' : self.status
	end
end
