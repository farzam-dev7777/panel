class ActivityLog < ApplicationRecord
	belongs_to :loggable, polymorphic: true

  belongs_to :law_firm, touch: true

	scope :notifications,  -> { where(notify: true) }
	scope :unread,  -> { where("notify = ? AND read != ?", true, true) }
	scope :read,  -> { where("notify = ? AND read = ?", true, true) }

	ACTION_TYPE_REASON = {
    account_created: 'Onboarded',
    todo_task_created: 'A Todo task was created',
    information_security_policy_request_initiated: 'SEAL process started',
    seal_certification_process_initiated: 'SEAL process started',
    information_security_policy_submitted: 'SEAL form submitted',
    information_security_policy_review_started: 'SEAL form under review',
    follow_up: 'Follow up requested',
    approved: 'SEAL Certification approved',
    declined: 'SEAL Certification declined',
    critical_security_alert: 'Critical Alert',
    high_security_alert: 'High Priority Alert',
    low_security_alert: 'Low Priority Alert',
    decertify: 'Decertified',
    recertification_process_initiated: 'Recertification process started',
    decrease_score: 'SEAL score impacted',
    action_item_marked_as_complete: 'The Firm has marked the security threat action item complete',
    login: "You last logged in at ",
    logout: "You last logged out at ",
    expiry_date_changed: "Expiry date changed ",
    technologies_updated: "Law firm has updated their technologies",
    history_updated: "Law firm has updated their history"
  }.freeze

	def self.log(object)
      object = object.merge(custom_message: ACTION_TYPE_REASON[object[:event_type].to_sym]) if !object[:custom_message] && object[:custom_message].blank?
      activity_log = ActivityLog.new(object)
      LawFirm.find_by(id: object[:law_firm_id]).try(:touch) if activity_log.save
	end

end
