class User < ApplicationRecord
  # acts_as_messageable
  acts_as_google_authenticated :column => :username, :method => :username, :issuer => 'SEAL'

  PANEL_ADMIN_USER_ROLES = ['lxp', 'lob', 'internal_lawyers']

  devise :database_authenticatable,
         :recoverable, :trackable, 
         :authentication_keys => [:username]

  has_one :law_firm
  has_many :activity_logs, as: :loggable

  belongs_to :law_firm

  default_scope { where(deactivated_at: nil) }

  scope :with_deactivated, -> { unscope(where: :deactivated_at) }

  attr_accessor :login, :send_password_reset_link, :empty_user

  before_validation :create_empty_user, if: :empty_user
  validate :password_complexity

  validates_uniqueness_of :email


  before_create :send_password_reset_link_email
  
  validates_presence_of  :email, :role
  validates_presence_of :password, if: :need_password_validation?
  validates_presence_of :password_confirmation, if: :need_password_validation?
  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }

  def email=(email)
    self.username = email
    super
  end

  def need_password_validation?
    !self.new_record? && !self.password.blank? && !self.password_confirmation.blank?
  end

  def send_password_reset_link_email
    if self.send_password_reset_link
      self.password  = self.password_confirmation = SecureRandom.hex(12)
      UserMailer.send_password_reset_link(self).deliver!
    end
  end

  def reset_password_link_url
    self.send(:set_reset_password_token)
    self.save(validate: false)
    Rails.application.routes.url_helpers.edit_user_password_url(reset_password_token: self.reset_password_token)
  end

  def activate!
    self.update_attributes(deactivated_at: nil)
  end

  def send_two_fa
    self.two_fa_key = SecureRandom.hex(3).upcase
    self.two_fa_key_expires_at = Time.now + 60.seconds
    self.save(validate: false)
    UserMailer.send_two_fa(self).deliver!
  end

  def authentic_email_two_factor?(code)
    self.two_fa_key === code && self.two_fa_key_expires_at >= Time.now
  end

  def send_user_info_with_password
    UserMailer.send_user_info_with_password(self).deliver!
  end
  
  def send_user_info_with_rfi
    UserMailer.send_user_info_with_password_with_rif(self).deliver!
  end

  def google_qr_uri
    "data:image/png;base64,#{Base64.encode64(open(super).to_a.join)}"
  end

  def is_panel_admin_user?
    User::PANEL_ADMIN_USER_ROLES.include?(self.role)
  end

  def create_empty_user
    self.password = self.password_confirmation = SecureRandom.hex(10) + "@A!123"
    self.deactivated_at = Time.now
  end

  def password_complexity
    return true if (password.blank? && !self.new_record?) || self.send_password_reset_link
    if password != password_confirmation
      errors.add :password, "both passwords should match" 
    end
    return if password.present? && password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{10,100}$/
    errors.add :password, 'complexity requirement not met. Length should be 10-100 characters and include: 1 Upper case, 1 lower case, 1 digit and 1 special char'
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username)
      where(conditions.to_h).first
    end
  end

  def mailboxer_email(object)
    #Check if an email should be sent for that object
    #if true
    return "define_email@on_your.model"
    #if false
    #return nil
  end

  Warden::Manager.after_authentication do |user,auth,opts|
    activity_object(user, 'login', 'in') if user && user.class.to_s != 'AdminUser' && user.role == 'user'
  end

  Warden::Manager.before_logout do |user,auth,opts|
    activity_object(user, 'logout', 'out') if user && user.class.to_s != 'AdminUser' && user.role == 'user'
  end

  def self.activity_object(user, event_type, task_string)
    object = {
      law_firm_id: user.law_firm.id,
      event_type: event_type,
      loggable: user,
      notify: false,
      source: user.class.to_s,
      email: user.email,
      custom_message: "You last logged #{task_string}"
    }
    ActivityLog.log(object)
  end

  def is_a_standard_user?
    self.role == 'user' || 'master_user'
  end 

  def is_an_admin?
    self.role == 'superadmin' || self.role == 'admin'
  end

  def is_a_master_user?
    role == 'master_user'
  end

  def is_deactivated?
    self.deactivated_at.present?
  end

end
