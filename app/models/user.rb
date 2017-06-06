class User < ApplicationRecord
  # acts_as_messageable
  acts_as_google_authenticated :column => :username

  devise :database_authenticatable,
         :recoverable, :trackable, 
         :validatable, :timeoutable, :authentication_keys => [:username]

  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }

  has_one :law_firm
  has_many :activity_logs, as: :loggable

  default_scope { where("deactivated_at IS NULL") }

  attr_accessor :login

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
    self.role == 'user'
  end 

end
