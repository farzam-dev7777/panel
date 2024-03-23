class LawyerMatterIntake < ApplicationRecord
  belongs_to :lawyer, class_name: 'User', foreign_key: 'user_id'
  belongs_to :matter_intake

  after_commit :send_notification_to_lawyer, on: [:create]


  def send_notification_to_lawyer
  	self.matter_intake.send_notification_to_lawyer(self.lawyer.email)
  end
end
