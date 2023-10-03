class MatterApproval < ApplicationRecord

  belongs_to :user
  belongs_to :matter_intake

   MATTER_APPROVAL_STATUS = {
    pending: "Pending",
    rejected: "Rejected",
    approved: 'Approved'
  }

   MATTER_APPROVAL_ROLE = {
    lxp: "LXP",
    lob: "LOB",
    master_user: "Law Firm",
    internal_lawyers: 'Internal Layer'
  }

  attr_accessor :description

  def self.create_matter_approval(matter_intake_id, role, approval_type, approval_sequence=0)
  	if self.where(matter_intake_id: matter_intake_id, approve_by_role: role, approval_type: approval_type).blank?
  		create(matter_intake_id: matter_intake_id, approve_by_role: role, approval_type: approval_type, status: 'pending', approval_sequence: approval_sequence)
  	end
  end

  def self.pending
  	where(status: 'pending')
  end

  def self.approved
  	where(status: 'approved')
  end

  def self.rejected
  	where(status: 'rejected')
  end

  def show_status
    if approval_type == 'consent'
      MATTER_APPROVAL_STATUS[status.to_sym]
    else
      MATTER_APPROVAL_STATUS[status.to_sym]
    end
  end

  def show_role
    MATTER_APPROVAL_ROLE[approve_by_role.to_sym]
  end
end
