class User < ApplicationRecord
  acts_as_messageable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,#, :registerable,
         :recoverable,
         # :rememberable,
         :trackable,
         :validatable,
         :authentication_keys => [:username]

  has_one :law_firm
  has_many :activity_logs, as: :loggable

  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    } # etc.


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
end
