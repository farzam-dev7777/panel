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
  end

	def self.log_activity(event_type, notify, submission)

		object = {
  		law_firm_id: submission.law_firm_id,
  		event_type: event_type,
  		loggable: submission,
      notify: notify
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

end
