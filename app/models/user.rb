class User < ApplicationRecord
  # acts_as_messageable
  acts_as_google_authenticated :column => :username, :method => :username, :issuer => 'SEAL'

  devise :database_authenticatable,
         :recoverable, :trackable, 
         :validatable, :authentication_keys => [:username]

  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }

  has_one :law_firm
  has_many :activity_logs, as: :loggable

  belongs_to :law_firm

  default_scope { where("deactivated_at IS NULL") }

  attr_accessor :login

  validate :password_complexity

  def google_qr_uri
    "data:image/png;base64,#{Base64.encode64(open(super).to_a.join)}"
  end

  def password_complexity
    return true if password.blank? && !self.new_record?
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

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
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

end
