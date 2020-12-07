class ConflictWaiver < ApplicationRecord

  self.per_page = 10
  belongs_to :user
  belongs_to :law_firm
  has_many :activity_logs
  has_many :reviews, as: :reviewable

  serialize :types_of_matters, Array

  validates_presence_of :name_of_law_firm, :contact_details, :bmo_business_contact, :reason #, :retainer_language

  #validate :confirm_waiver_must_be_true

  CONFLICT_WAIVER_STATUS = {
    "APPROVED": "Approved",
    "REJECTED": "Rejected",
    "IN_REVIEW": "In Review",
    "ALREADY_COVERED": "Covered under retainer",
    "REQUEST_INFO": "More info required",
    "ASSIGN_TO_LAWYER": "Assigned to lawyer",
    "IN_REVIEW_LXP": "In Review (LXP)",
  }

  CONFLICT_WAIVER_STATUS_LXP = {
    "ALREADY_COVERED": "Covered under retainer",
    "APPROVED": "Approved",
    "REQUEST_INFO": "More info required",
    "ASSIGN_TO_LAWYER": "Assigned to lawyer",
    "IN_REVIEW_LXP": "In Review (LXP)",
    "REJECTED": "Rejected"
  }



  CONFLICT_WAIVER_STATUS_LAWYER = {
    "APPROVED": "Approved",
    "REJECTED": "Rejected",
    "REQUEST_INFO": "Request Info ",
    "IN_REVIEW": "In Review"
  }


  RETAINER_LANGUAGE_TYPE = [
    "An issuer or selling security holder in an underwriting",
    "A borrower in a normal course borrowing/mortgage transaction when we are already represented by other counsel",
    "A customer in the ordinary course of our business",
    "A party to a transaction where we are a lender or advisor to another party to the transaction",
    "A debtor in a bankruptcy, insolvency, restructuring or other similar proceeding that adjusts creditors’ rights where we are a creditor in such proceeding, provided that (i) you did not act directly or indirectly for us in the transaction or arrangement giving rise to our claim, and (ii) you notify us that you represent the debtor",
    "A party in a transaction to which we are not a party but where you acted on our behalf in a previous lending transaction with that party, provided that (i) the current transaction is unrelated to the previous lending transaction and (ii) it will have no bearing and/impact on the previous lending transaction."
  ]
  
  
  # def confirm_waiver_must_be_true
  #   errors.add(:confirm_waiver, "you must confirm that this waiver is not covered by the above waivers") if self.confirm_waiver != true
  # end

  def can_user_change_status?(current_user)
    if current_user.role === 'lxp'
      self.lxp_status != 'APPROVED' || self.internal_lawyers_status === 'REQUEST_INFO'  
    elsif current_user.role === 'internal_lawyers'
      self.internal_lawyers_status != 'APPROVED'
    end
  end

  def fully_approved?
    self.lxp_status === 'APPROVED' && self.internal_lawyers_status === 'APPROVED'
  end

  def lxp_status_show
    ConflictWaiver::CONFLICT_WAIVER_STATUS[self.lxp_status.try(:to_sym)]
  end

  def internal_lawyers_status_show
    if self.lxp_status.present?
      ConflictWaiver::CONFLICT_WAIVER_STATUS[self.lxp_status.to_sym]
    end
  end
  
  def internal_lawyers_status_show
    if self.internal_lawyers_status.present?
      if self.internal_lawyers_status === "REQUEST_INFO"
        ConflictWaiver::CONFLICT_WAIVER_STATUS[self.internal_lawyers_status.to_sym]
      elsif self.internal_lawyers_status === "APPROVED" 
        ConflictWaiver::CONFLICT_WAIVER_STATUS_LAWYER[self.internal_lawyers_status.to_sym]
      else
        ConflictWaiver::CONFLICT_WAIVER_STATUS[self.internal_lawyers_status.to_sym]
      end

    end
  end
  
  def log_activity(event_type, notify = false, current_user)

  	object = {
  		law_firm_id: current_user.law_firm.id,
  		event_type: event_type,
      loggable: self,
      notify: notify,
      source: current_user.class,
      email: current_user.email,
      current_user: current_user,
  	}
  	ActivityLog.log(object)
  end

end
