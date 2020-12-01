class FormSubmission < ApplicationRecord
  include Submittable
  include HasAttachedFiles
  belongs_to :law_firm
  belongs_to :last_submitted_by, class_name: User
  has_many :technology_values
  has_many :history_submissions
  has_many :notes
  has_many :follow_ups
  has_many :file_attachments, as: :attachable, dependent: :destroy
	accepts_nested_attributes_for :technology_values, allow_destroy: true, reject_if: proc { |attributes| attributes['vendor'].blank? && attributes['platform'].blank? && attributes['version'].blank? && attributes['service_pack'].blank? && attributes['supported'].blank? }
	accepts_nested_attributes_for :history_submissions, allow_destroy: true, reject_if: proc { |attributes| attributes['incident_type'].blank? && attributes['impact'].blank? && attributes['discovery_time'].blank? && attributes['source'].blank? && attributes['data_loss'].blank? && attributes['incident_details'].blank? }

  scope :approved, -> { where(status: 'approved') }
  scope :latest,   -> { order(:id).last }

  TOTAL_SCORE = 5.0

  amoeba do
    enable
    include_association :form_values
    include_association :technology_values
    include_association :history_submissions
  end

	def self.log_activity(event_type, notify, submission, current_user, custom_message=nil)
		object = {
  		law_firm_id: submission.law_firm_id,
  		event_type: event_type,
  		loggable: submission,
      notify: notify,
      source: current_user.class,
      email: current_user.email,
      custom_message: custom_message,
      current_user: current_user
  	}
  	ActivityLog.log(object)
	end

  def formatted_status
    self.status == 'decline' ? "Submission Reviewed" : self.status.try(:titleize)
   
  end

  def formatted_evidence_status
    (self.evidence_status || "Under Review").humanize
  end

  def self.generate_initial_submissions(law_firm, current_user)
    submission = FormSubmission.new
    submission.form_id = Form.where(step: 'pricing').last.try(:id)
    submission.form_relationship_id = Form.where(step: 'relationship').last.try(:id)
    submission.form_diversity_id = Form.where(step: 'diversity').last.try(:id)
    submission.form_innovation_id = Form.where(step: 'innovation').last.try(:id)
    submission.form_resourcing_id = Form.where(step: 'resourcing').last.try(:id)
    submission.law_firm_id =  law_firm.id
    submission.status = 'sent'
    submission.save

    LawFirmMailer.initial_submissions_generated(law_firm).deliver_now
    log_activity('information_security_policy_request_initiated', true, submission, current_user) if submission.save
  end

  def can_be_approved?
    self.total_score >= SystemSetting.score_threshold
  end

  def self.check_for_expiry
    start_date = Time.now.beginning_of_day
    end_date = Time.now.end_of_day
    @form_submissions = FormSubmission.where(created_at: start_date..end_date)
    if @form_submissions.any?
      @form_submissions.each do |form_submission|
        AdminMailer.submission_expired(form_submission).deliver_now
      end
    end
  end

  def check_total_score_before_approval
    (((self.system_score || 0) * LawFirm::SYSTEM_SCORE_WEIGHTAGE) + 
        ((self.assessor_score || 0) * LawFirm::ASSESSOR_SCORE_WEIGHTAGE) + 
        (self.law_firm.responsiveness_rate * LawFirm::RESPONSIVENESS_SCORE_WEIGHTAGE)).round(1)
  end

  def check_follow_ups
    FollowUp.where(form_submission_id: self.id).map(&:status).count('pending') > 0
  end

  def system_score_median 
    ((TOTAL_SCORE - SystemSetting.score_threshold) / 2) + SystemSetting.score_threshold
  end

  def color(score, type)
    return 'grey' unless score
    if (score >= 0 && score <= SystemSetting.score_threshold)
      '#ff0000'
    elsif (score > SystemSetting.score_threshold && score <= system_score_median)
      '#F6D300'
    else
      '#00B026'
    end
  end

  def is_available_to_user
    open_states = ["sent", "started", "follow_up"]
    open_states.include? self.status
  end

  def render_history_submission_fields
    self.history_submissions.any? ? self.history_submissions : [self.history_submissions.build]
  end

  def decision_made?
    ['approved', 'decline', 'follow_up'].include? self.status
  end

  def decision_decline?
    ['decline'].include? self.status
  end

end
