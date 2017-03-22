class LawFirm < ApplicationRecord
  self.per_page = 10
  belongs_to :user
  has_many :activity_logs
  has_many :requests
  has_many :todo_tasks
  has_many :form_submissions
  has_many :action_items
  has_many :internal_notes

  after_create :generate_a_new_user
  acts_as_messageable

  attr_accessor :temp_password

  EMAIL_PREFIX = "@check.com"

  TIME_FORMAT = "%d %b %y, %I:%M %Z"

  def approved_and_scored
    LawFirm.joins(:form_submissions).where("form_submissions.status = 'approved' AND form_submissions.total_score IS NOT NULL")
  end

  def generate_a_new_user
    self.create_user!(email: "#{SecureRandom.hex(4)}#{EMAIL_PREFIX}", 
                      username: SecureRandom.hex(4), 
                      password: self.temp_password)
  end

  def log_activity(event_type, notify = false, current_user)
  	object = {
  		law_firm_id: id,
  		event_type: event_type,
      loggable: self,
      notify: notify,
      source: current_user.class,
      email: current_user.email
  	}
  	ActivityLog.log(object)
  end

  def add_internal_note(message, admin)
    internal_note = InternalNote.new(message: message, sender_id: admin.id, law_firm_id: self.id)
    internal_note if internal_note.save
  end

  def self.certified
    LawFirm.joins(:form_submissions).where("form_submissions.created_at = (SELECT MAX(form_submissions.created_at) FROM form_submissions WHERE form_submissions.law_firm_id = law_firms.id) AND form_submissions.status='approved'")
  end
  def self.in_process
    LawFirm.joins(:form_submissions).where("form_submissions.created_at = (SELECT MAX(form_submissions.created_at) FROM form_submissions WHERE form_submissions.law_firm_id = law_firms.id) AND form_submissions.status='sent' OR  form_submissions.status='submitted' OR  form_submissions.status='started'")
  end
  def self.decertified
    LawFirm.joins(:form_submissions).where("form_submissions.created_at = (SELECT MAX(form_submissions.created_at) FROM form_submissions WHERE form_submissions.law_firm_id = law_firms.id) AND form_submissions.status='decertified' OR form_submissions.status='decline'")
  end
  def self.onboarded
    LawFirm.where('id NOT IN (SELECT DISTINCT(law_firm_id) FROM form_submissions)')
  end
end
