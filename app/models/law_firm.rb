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

  def approved_and_scored
    LawFirm.joins(:form_submissions).where("form_submissions.status = 'approved' AND form_submissions.total_score IS NOT NULL")
  end

  def generate_a_new_user
    self.create_user!(email: "#{SecureRandom.hex(4)}#{EMAIL_PREFIX}", 
                      username: SecureRandom.hex(4), 
                      password: self.temp_password)
  end

  def log_activity(event_type, notify = false)
  	object = {
  		law_firm_id: id,
  		event_type: event_type,
      loggable: self,
      notify: notify
  	}
  	ActivityLog.log(object)
  end

  def add_internal_note(message, admin)
    internal_note = InternalNote.new(message: message, sender_id: admin.id, law_firm_id: self.id)
    internal_note if internal_note.save
  end
end
