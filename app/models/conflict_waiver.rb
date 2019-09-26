class ConflictWaiver < ApplicationRecord

  self.per_page = 10
  belongs_to :user
  belongs_to :law_firm
  has_many :activity_logs
  has_many :reviews, as: :reviewable

  validates_presence_of :name_of_law_firm, :contact_details, :bmo_business_contact, :reason

  validate :confirm_waiver_must_be_true

  CONFLICT_WAIVER_STATUS = {
    "ALREADY_COVERED": "Already Covered",
    "APPROVES": "Approves",
    "REJECTS": "Rejects"
  }
  
  def confirm_waiver_must_be_true
    errors.add(:confirm_waiver, "you must confirm that this waiver is not covered by the above waivers") if self.confirm_waiver != true
  end

  def can_user_change_status?(current_user)
    if current_user.role === 'lxp'
      self.lxp_status != 'approved'
    else
    end
  end

  def fully_approved?
    self.lxp_status === 'approved' && self.internal_lawyers_status === 'approved'
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
