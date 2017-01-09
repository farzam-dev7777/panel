class LawFirm < ApplicationRecord
  belongs_to :user

  after_create :generate_a_new_user

  attr_accessor :temp_password

  EMAIL_PREFIX = "@check.com"

  def generate_a_new_user
    self.create_user!(email: "#{SecureRandom.uuid}#{EMAIL_PREFIX}", username: SecureRandom.uuid, password: self.temp_password)
  end
end
