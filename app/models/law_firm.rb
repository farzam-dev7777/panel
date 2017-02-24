class LawFirm < ApplicationRecord
  self.per_page = 10
  belongs_to :user
  has_many :activity_logs
  has_many :requests

  after_create :generate_a_new_user
  acts_as_messageable

  attr_accessor :temp_password

  EMAIL_PREFIX = "@check.com"

	ACTION_OBJECT_TYPES = {
    account_created: User
  }.freeze

  def generate_a_new_user
    self.create_user!(email: "#{SecureRandom.uuid}#{EMAIL_PREFIX}", username: SecureRandom.uuid, password: self.temp_password)
  end

  def log_activity(event_type, notify = false)
  	object = {
  		law_firm_id: id,
  		event_type: event_type,
  		loggable: self.send(ACTION_OBJECT_TYPES[event_type.to_sym].to_s.downcase.to_sym),
      notify: notify
  	}
  	ActivityLog.log(object)
  end
end
