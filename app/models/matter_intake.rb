class MatterIntake < ApplicationRecord

  self.per_page = 10
  belongs_to :user
  belongs_to :law_firm
  belongs_to :matter_type
  belongs_to :lawyer, class_name: 'InternalLawyer', foreign_key: 'lawyer_id'

  has_many :reviews, as: :reviewable

  validates_presence_of :submitter_name, :matter_type_id, :if => Proc.new { |matter_intake| matter_intake.user_id.present? }
  # validates_presence_of  :if => Proc.new { |matter_intake| matter_intake.user_id.present? }

  LOB_CONTACT_NAMES = [
    "MANISH",
    "KHEM CHAND",
    "RAHUL",
    "VISHAL",
    "MANPREET SINGH",
    "JASDEEP SINGH",
    "SANDEEP"
  ]

  LegalGroupBMOLawyer = [
    'BMO Group 1',
    'BMO Group 2',
    'BMO Group 3',
  ]

  WorkArea = [
    'Regulatory',
    'Board Reporting',
    'Work Area 2',
    'Work Area 3'
  ]

  Jurisdiction = ["Canada", "United States of America"]

  TypeOfPrice = [
    'Hourly Billing',
    'Work done at no cost',
    'Option3',
    'Option4'
  ]

  OtherParty = [
    'Option1',
    'Option2',
    'Option3'
  ]

  FirmType = ['Panel', 'Non-Panel', 'Panel & Non-Panel Firms']

  def send_notification_to_lawyer
    MatterIntakeMailer.send_notification_to_lawyer_for_form_submission(self).deliver_now
  end

  def send_notification_to_lxp
    MatterIntakeMailer.send_notification_to_lxp_for_form_submission(self).deliver_now
  end

  def send_notification_to_lawyer_and_lxp
    MatterIntakeMailer.send_notification_to_lxp_for_matter_open(self).deliver_now
    MatterIntakeMailer.send_notification_to_lawyer_for_matter_open(self).deliver_now
  end

  def send_notification_to_lawyer_form_needs_updation
    MatterIntakeMailer.send_notification_to_lawyer_form_needs_updation(self).deliver_now
  end

  def add_log_for_lawyer_submission_to_lxp(current_user)
    Review.create(
      actor_id: current_user.id,
      reviewable_type: self.class.to_s,
      reviewable_id: self.id,
      description: "#{self.lawyer.try(:full_name)} submitted matter intake form for LXP review.",
      status: "waiting_for_lxp_review"
    )
  end

  def add_log_for_lxp_rejects_and_returns_to_lawyer(current_user)
    Review.create(
      actor_id: current_user.id,
      reviewable_type: self.class.to_s,
      reviewable_id: self.id,
      description: "#{current_user.try(:full_name)} rejects matter intake form and retuns to lawyer for completion/updation.",
      status: "waiting_for_lawyer_updation"
    )
  end

  def add_log_matter_open_by_lxp(current_user)
    Review.create(
      actor_id: current_user.id,
      reviewable_type: self.class.to_s,
      reviewable_id: self.id,
      description: "#{current_user.try(:full_name)} mark matter open in T360 with matter number #{self.matter_number}.",
      status: "matter_open"
    )
  end

end
