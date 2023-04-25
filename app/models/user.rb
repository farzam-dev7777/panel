class User < ApplicationRecord
  # acts_as_messageable
  acts_as_google_authenticated :column => :username, :method => :username, :issuer => 'SEAL'

  PANEL_ADMIN_USER_ROLES = ['lxp', 'lob', 'internal_lawyers']
  TENANT_ADMIN_USER_ROLES = ['tenant_admin']
  USER_STATUS = ['Activate', 'Deactivate']
  devise :database_authenticatable,
         :recoverable, :trackable, 
         :authentication_keys => [:username]

  devise :omniauthable, omniauth_providers: [:okta, :azure_activedirectory_v2]

  has_one :law_firm
  has_many :activity_logs, as: :loggable

  belongs_to :law_firm
  belongs_to :tenant
  has_many   :matter_intakes

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

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "current_sign_in_at", "current_sign_in_ip", "deactivated_at", "email", "encrypted_password", "first_name", "google_secret", "id", "last_name", "last_sign_in_at", "last_sign_in_ip", "law_firm_id", "line_of_business", "lob_contact_name", "new_password_set", "otp_secret_key", "provider", "provider_group", "provider_uid", "qr_code_confirmed_at", "remember_created_at", "reset_password_sent_at", "reset_password_token", "role", "sign_in_count", "status", "two_fa_key", "two_fa_key_expires_at", "updated_at", "username"]
  end

  def full_name
    [self.first_name, self.last_name].compact.join(' ')
  end

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
    if self.reset_password_token.nil?
      self.send(:set_reset_password_token)
    end
    self.save(validate: false)
    Rails.application.routes.url_helpers.edit_user_password_url(reset_password_token: self.reset_password_token)
  end

  def activate!
    self.update(deactivated_at: nil)
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
    self.role == 'user' || self.role == 'master_user'
  end 

  def is_an_admin?
    self.role == 'superadmin' || self.role == 'admin'
  end

  def is_a_master_user?
    role == 'master_user'
  end

  def is_a_tenant_admin?
    self.role == 'tenant_admin'
  end

  def is_deactivated?
    self.deactivated_at.present?
  end

  def self.from_omniauth_okta(auth)
    headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "SSWS #{Tenant.current&.okta_api_token}"
    }
    begin
      response = RestClient.get("#{Rails.application.secrets[:okta][:site]}/api/v1/users/#{auth['uid']}/groups", headers=headers)
      # response = RestClient.get("#{Rails.application.secrets[:okta]['site']}/api/v1/users/#{auth['uid']}", headers=headers)
      result = JSON.parse(response&.body) if response&.body.present?

      user_groups = result.select {|group| group['type'] === "OKTA_GROUP" && ["Panel - Internal Lawyers", "Panel - Master User", "Panel - Business User"].include?(group['profile']['name']) } if result.present?
      user_group = user_groups.first
      # If user_group present then we find or create user in our database
      if user_group.present?
        group_name = user_group.fetch('profile', {}).fetch('name', "")
        if group_name.present?
          case group_name
            when "Panel - Internal Lawyers"
              role = "internal_lawyers"
            when "Panel - Master User"
              role = "lxp"
            when "Panel - Business User"
              role = "lob"
            else
              role = ""
          end
          random_password = "#{SecureRandom.hex(18)}@A123"
          user = User.find_or_create_by(email: auth['info']['email']&.downcase) do |user|
            user.first_name = auth['info']['first_name']
            user.last_name = auth['info']['last_name']
            user.provider = auth['provider']
            user.provider_uid = auth['uid']
            user.email = auth['info']['email']
            user.provider_group = group_name
            user.password = random_password
            user.password_confirmation = random_password
            user.role = role
            user.new_password_set = true
          end
          user.save
          user
        end
      end
    rescue RestClient::ExceptionWithResponse => e
      # e.response
      user = nil
    end
  end

  def self.from_omniauth_azure(auth)
    headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer #{auth['credentials']['token']}"
    }
    begin
      response = RestClient.get("https://graph.microsoft.com/v1.0/me/memberOf", headers = headers)
      result = JSON.parse(response&.body)["value"] if response&.body.present?

      user_groups = result.select {|group| group['@odata.type'] === "#microsoft.graph.group" && ["Panel - Internal Lawyers", "Panel - Master User", "Panel - Business User"].include?(group['displayName']) } if result.present?
      user_group = user_groups.first
      # If user_group present then we find or create user in our database
      if user_group.present?
        group_name = user_group.fetch('displayName', "")
        if group_name.present?
          case group_name
            when "Panel - Internal Lawyers"
              role = "internal_lawyers"
            when "Panel - Master User"
              role = "lxp"
            when "Panel - Business User"
              role = "lob"
            else
              role = ""
          end
          random_password = "#{SecureRandom.hex(18)}@A123"
          decoded_token = JWT.decode(auth['credentials']['token'], nil, false).first
          user = User.find_or_create_by(email: decoded_token['email']&.downcase) do |user|
            user.first_name = auth['info']['first_name']
            user.last_name = auth['info']['last_name']
            user.provider = auth['provider']
            user.provider_uid = auth['uid']
            user.email = decoded_token['email']&.downcase
            user.provider_group = group_name
            user.password = random_password
            user.password_confirmation = random_password
            user.role = role
            user.new_password_set = true
          end
          user.save
          user
        end
      end
    rescue RestClient::ExceptionWithResponse => e
      # e.response
      user = nil
    end
  end
end
