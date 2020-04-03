class MatterIntake < ApplicationRecord

  self.per_page = 10
  belongs_to :user
  belongs_to :law_firm
  belongs_to :matter_type
  belongs_to :lawyer, class_name: 'InternalLawyer', foreign_key: 'lawyer_id'

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
end
