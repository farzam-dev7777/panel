class TenantAdminUser < ApplicationRecord
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :tenant

  validates_presence_of  :email, :role
  validates_presence_of :password, if: :need_password_validation?
  validates_presence_of :password_confirmation, if: :need_password_validation?
  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }

  def full_name
    [self.first_name, self.last_name].compact.join(' ')
  end

  def need_password_validation?
    !self.new_record? && !self.password.blank? && !self.password_confirmation.blank?
  end
end
