class ExceptionRequest < ApplicationRecord

  #serialize :matter_types, Array

  self.per_page = 10
  belongs_to :user
  belongs_to :law_firm
  has_many :activity_logs
  has_many :reviews, as: :reviewable

  LOB_LIST = ["Canadian P&C", "Capital Markets", "Corporate", "Technology & Operations", "US P&C", "Wealth Management"]
  REQUEST_TYPE = {
    "EXCEPTION": "Exception",
    "ADD_TO_LAW_FIRM_PANEL": "Add to Law Firm Panel"
  }
  LAW_FIRM_CATEGORIES = {
    "PANEL": "Panel",
    "NON_PANEL": "Non Panel"
  }

  MATTER_TYPES = ["MATTER_TYPE_1", "MATTER_TYPE_2", "MATTER_TYPE_3"]
  MINORITY_OWNED_TYPE = ["Yes", "No"]
  WOMEN_OWNED_TYPE = ["Yes", "No"]

  validates_presence_of :requested_by, :submitted_by_email, :line_of_business, :lob_contact_name, :law_firm_category, :minority_owned, :women_owned, :matter_name

  belongs_to :law_firm



  def can_user_change_status?(current_user)
    
    if self.internal_lawyers_status === "REJECTED"
      self.internal_lawyers_status != 'APPROVED'  
    elsif self.internal_lawyers_status === "APPROVED"
      self.lxp_status != 'REJECTED'
    elsif current_user.role === 'lxp' 
      self.lxp_status != 'APPROVED'
    elsif current_user.role === 'internal_lawyers'
      self.internal_lawyers_status != 'APPROVED'
    end
  end

  EXCEPTION_REQUEST_STATUS = {
    "ALREADY_COVERED": "Already Covered",
    "APPROVED": "Approved",
    "REJECTED": "Rejected"
  }

  def waiting_for_internal_lawyers_approval?
    self.lxp_id.present? && self.internal_lawyers_id.present? &&  self.lxp_status.nil?
  end
  
  def fully_approved?
    self.lxp_status === 'APPROVED' && self.internal_lawyers_status === 'APPROVED'
  end

  def lxp_status_show
    if self.lxp_status.present?
      ExceptionRequest::EXCEPTION_REQUEST_STATUS[self.lxp_status.to_sym]
    end
  end
  def internal_lawyers_status_show
    if self.internal_lawyers_status.present?
      ExceptionRequest::EXCEPTION_REQUEST_STATUS[self.internal_lawyers_status.to_sym]
    end
  end
end
