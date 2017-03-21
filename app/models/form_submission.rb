class FormSubmission < ApplicationRecord
  include Submittable
  belongs_to :law_firm
  has_many :technology_values
  has_many :history_submissions
  has_many :notes
  has_many :follow_ups
	accepts_nested_attributes_for :technology_values
	accepts_nested_attributes_for :history_submissions

  scope :approved, -> { where(status: 'approved') }
  scope :latest,   -> { order(:id).last }

  amoeba do
    enable
    include_association :form_values
    include_association :technology_values
    include_association :history_submissions
  end

	def self.log_activity(event_type, notify, submission, current_user)

		object = {
  		law_firm_id: submission.law_firm_id,
  		event_type: event_type,
  		loggable: submission,
      notify: notify,
      source: current_user.class,
      email: current_user.email
  	}
  	ActivityLog.log(object)
	end

  def self.generate_initial_submissions(law_firm)
    submission = FormSubmission.new
    submission.form_id = Form.where(step: 'policy').last.try(:id)
    submission.form_process_id = Form.where(step: 'process').last.try(:id)
    submission.law_firm_id = law_firm.id
    submission.status = 'sent'
    submission.save

    log_activity('information_security_policy_request_initiated', true, submission) if submission.save
  end

  def can_be_approved?
    self.total_score >= SystemSetting.score_threshold
  end

end
