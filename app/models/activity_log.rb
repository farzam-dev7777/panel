class ActivityLog < ApplicationRecord
	belongs_to :loggable, polymorphic: true

  belongs_to :law_firm

	scope :notifications,  -> { where(notify: true) }
	scope :unread,  -> { where("notify = ? AND read != ?", true, true) }
	scope :read,  -> { where("notify = ? AND read = ?", true, true) }

	ACTION_OBJECT_TYPES = {
    account_created: User,
    todo_task_created: TodoTask,
    information_security_policy_request_initiated: FormSubmission,
    seal_certification_process_initiated: FormSubmission,
    information_security_policy_submitted: FormSubmission,
    information_security_policy_review_started: FormSubmission,
    follow_up: FormSubmission,
    approved: FormSubmission,
    declined: FormSubmission,
    recertification_process_initiated: FormSubmission
	}

	ACTION_TYPE_REASON = {
    account_created: 'Firm\'s account was created',
    todo_task_created: 'A Todo task was created',
    information_security_policy_request_initiated: 'Request for information security policy initiated',
    seal_certification_process_initiated: 'SEAL Certification process started',
    information_security_policy_submitted: 'Information security policy submitted',
    information_security_policy_review_started: 'Review for information security policy started',
    follow_up: 'The assessor requested follow up question(s)',
    approved: 'The SEAL Certification has been approved',
    declined: 'The SEAL Certification has been declined',
    recertification_process_initiated: 'The assessor initiated a recertification process',
    critical_security_alert: 'There is a critical security alert',
    high_security_alert: 'There is a high priority security threat',
    low_security_alert: 'There is a security threat',
    decertify: 'The firm has been decertified',
    recertification_process_initiated: 'The recertification process has been initiated'
  }.freeze

	def self.log(object)
		activity_log = ActivityLog.new(object)
		object = object.merge(custom_reason: ACTION_TYPE_REASON[object[:event_type].to_sym]) unless object[:custom_reason]
		activity_log.save
	end
	
end
