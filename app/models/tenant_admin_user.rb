class TenantAdminUser < ApplicationRecord
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:username]

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

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username)
      where(conditions.to_h).first
    end
  end
end
