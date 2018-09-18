class LawFirm < ApplicationRecord
  generate_public_uid
  self.per_page = 10
  belongs_to :user
  has_many :users
  has_many :activity_logs
  has_many :requests
  has_many :todo_tasks
  has_many :form_submissions
  has_many :action_items
  has_many :internal_notes
  has_many :locations
  has_many :jurisdictions
  has_many :history_submissions

  serialize :practice_area, Array
  serialize :type_of_matters_your_law_firm_handles_for_us, Array
  serialize :type_of_services_your_law_firm_provides_generally, Array

  accepts_nested_attributes_for :history_submissions

  accepts_nested_attributes_for :locations
  accepts_nested_attributes_for :jurisdictions
  accepts_nested_attributes_for :users, allow_destroy: true

  after_create :generate_a_new_user
  # acts_as_messageable

  validate :password_complexity

  USER_LIMIT = 3

  PRACTICE_AREAS = ["Administrative law","Advertising law","Admiralty law","Agency law","Alcohol law","Alternative dispute resolution","Animal law","Antitrust law (or competition law)","Appellate practice","Art law (or art and culture law)","Aviation law","Banking law","Bankruptcy law (creditor debtor rights law or insolvency and reorganization law)","Bioethics","Bird law","Business law (or commercial law); commercial litigation","Business organizations law (or companies law)","Civil law or common law","Class action litigation/Mass tort litigation","Communications law","Computer law","Conflict of law (or private international law)","Constitutional law","Construction law","Consumer law","Contract law","Copyright law","Corporate law (or company law)"," also corporate compliance law and corporate governance law","Criminal law","Cryptography law","Cultural property law","Custom (law)","Cyber law","Defamation","Derivatives and futures law","Drug control law","Elder law","Employee benefits law (ERISA)","Employment law","Energy law","Entertainment law","Environmental law","Equipment finance law","Evidence","Family law","FDA law","Financial services regulation law","Firearm law","Food law","Franchise law","Gaming law","Health and safety law","Health law","Immigration law","Insurance law","Intellectual property law","International law","International trade and finance law","Internet law","Juvenile law","Labour law (or Labor law)","Land use & zoning law","Litigation","Martial law","Media law","Medical law","Mergers & acquisitions law","Military law","Mining law","Music law","Mutual funds law","Nationality law","Native American law","Obscenity law","Oil & gas law","Parliamentary law","Patent law","Poverty law","Privacy law","Private equity law","Private funds law / Hedge funds law","Procedural law","Product liability litigation","Property law","Public health law","Public International Law","Railroad law","Real estate law","Securities law / Capital markets law","Social Security disability law","Space law","Sports law","Statutory law","Tax law","Technology law","Timber law","Tort law","Trademark law","Transport law / Transportation law","Trusts & estates law","Utilities Regulation","Venture capital law","Water law","Sexual Law"].freeze
  COMPANY_TYPES = ["LP", "LLP", "LLC", "S", "CORP/SOLE", "PROP"].freeze
  TYPES_OF_MATTERS = ["Aboriginal","Acquisition finance and corporate lending","Administrative and public law","Alternative dispute resolution (ADR)","Antitrust and competition","Appellate","Asset based lending","Asset finance","Aviation","Banking and finance","Bankruptcy, financial restructuring and insolvency","Business ethics and anti-corruption","Business immigration and international mobility","Business method patents","Business services","Canadian North and Arctic","Cannabis","Capital markets","Cartels and antitrust investigation","Chapter 11 debtor and trustee representation","Charities and tax exempt organizations","Class actions","Cleantech and renewable energy","Communications, media and entertainment","Construction, engineering and infrastructure","Consumer markets","Copyright and entertainment","Corporate and commercial","Corporate finance and securities","Corporate trustees","Cross-border insolvency representation","Debt capital markets","Derivatives","Dispute resolution and litigation","e-Discovery","Emerging tech services: Come grow with us","Employee benefits and executive compensation","Employment and labour","Energy","Environmental and social sustainability","Environmental law","Equity capital markets","Federal employment and labour","Financial institutions","Financial institutions, funds and creditor representation","Financial services regulation","Food and agribusiness","Forestry","Franchising","Fraud and asset recovery","Governance and directors' liability","Healthcare services","Immigration law","Infrastructure, mining and commodities","Infrastructure / Public-Private Partnerships","Insurance","Intellectual property","International arbitration","International trade","Life sciences and healthcare","Linguistic services","Merger control","Mergers and acquisitions","Mining and resources","Mining disputes","Municipal planning","Municipal restructuring and bankruptcy","Occupational health and safety and workers' compensation (workplace safety and insurance)","Official creditors’ committee representation","Oil and gas","Outsourcing","Patents","Pensions","Pharmaceuticals and life sciences","Ports","Power and utilities","Privacy and access to information","Private equity","Product liability","Professional liability","Rail","Real estate","Recall and crisis management","Regulation and investigations","Renewables","Risk advisory","Securities litigation, regulation and enforcement","Securitization","Shipping","Sourcing and technology","Special situations","Structured trade and commodity finance","Sustainability and climate change","Tax","Technology","Technology and innovation","Trade-marks and branding","Trade secrets","Transnational litigation","Transport","Water","Wealth and private client","White-collar crime"].freeze
  TYPES_OF_MATTERS_FOR_US = ["Contractual Transactions (non-lending)","Corporate Governance","Employment (non-action)","General Customer Inquiries","Legal Administration","Lending & Financing (inc. Secured Transactions & Workouts)","M&A","Marketing","New Products","Real Estate","Regulatory","SAMU (Special Accounts Management Unit)","Tax","Intellectual Property","Wills/Estates"]
  NUMBER_OF_LAWYERS = ["<10", "<100", "<1000", ">1000"]
  
  JURISDICTION_COUNTRIES = ["Canada","United States of America"].freeze

  EMAIL_PREFIX = "@check.com"
  TIME_FORMAT = "%d %b %y, %I:%M %Z"
  DATE_FORMAT = "%d %b %y"
  SYSTEM_SCORE_WEIGHTAGE = 0.4
  RESPONSIVENESS_SCORE_WEIGHTAGE = 0.4
  ASSESSOR_SCORE_WEIGHTAGE = 0.2

  attr_accessor :temp_password

  def password_complexity
    return true if temp_password.blank? && !self.new_record?
    errors.add :temp_password, "must be present" if temp_password.blank?
    if temp_password != temp_password_confirmation
      errors.add :temp_password, "both passwords should match"
    end
    return if temp_password.present? && temp_password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{10,100}$/
    errors.add :temp_password, 'complexity requirement not met. Length should be 10-100 characters and include: 1 Upper case, 1 lower case, 1 digit and 1 special char'
  end

  def user
    User.where(law_firm_id: self.id).order(created_at: :asc).first
  end

  def approved_and_scored
    LawFirm.joins(:form_submissions).where("form_submissions.status = 'approved' AND form_submissions.total_score IS NOT NULL")
  end

  def law_firm_user_limit
    self.max_users || USER_LIMIT
  end

  def name
    self.public_uid  
  end

  def generate_a_new_user
    username = SecureRandom.hex(4)
    user = self.create_user!(email: "#{username}#{EMAIL_PREFIX}", 
                             username: username, 
                             password: self.temp_password,
                             password_confirmation: self.temp_password_confirmation,
                             role: 'master_user',
                             law_firm_id: self.id)
    user.set_google_secret
  end

  def standard_users
    users.where(role: 'user')
  end

  def log_activity(event_type, notify = false, current_user)
  	object = {
  		law_firm_id: id,
  		event_type: event_type,
      loggable: self,
      notify: notify,
      source: current_user.class,
      email: current_user.email,
      current_user: current_user
  	}
  	ActivityLog.log(object)
  end

  def add_internal_note(message, admin)
    internal_note = InternalNote.new(message: message, sender_id: admin.id, law_firm_id: self.id)
    internal_note if internal_note.save
  end

  def total_calculated_score
    latest_form_submission = self.form_submissions.latest

    return unless latest_form_submission.status == 'approved'

    (((latest_form_submission.system_score || 0) * SYSTEM_SCORE_WEIGHTAGE) + 
        ((latest_form_submission.assessor_score || 0) * ASSESSOR_SCORE_WEIGHTAGE) + 
        (responsiveness_rate * RESPONSIVENESS_SCORE_WEIGHTAGE)).round(1)
  end

  def responsiveness_rate

    critical_action_items = self.action_items.joins("INNER JOIN security_threats ON security_threats.id = action_items.security_threat_id INNER JOIN severity_levels ON severity_levels.id = security_threats.severity_level_id").where("severity_levels.name = 'critical' ")

    total_notifications = QueuedNotification.unscoped.where('trigger_at < ? AND action_item_id IN (?)', Time.now, critical_action_items.map(&:id)).count
    missed_notifications = QueuedNotification.unscoped.where('trigger_at < ? AND triggered = ? AND action_item_id IN (?)', Time.now, true, critical_action_items.map(&:id)).count
    #critical_action_items.select { |item| item.queued_notifications.where('trigger_at < ?, triggered = ?, ', Time.now, true) }.count
    #total_notifications = critical_action_items.select { |item| item.queued_notifications.where('trigger_at < ?', Time.now) }.count
    #missed_notifications = critical_action_items.select { |item| item.queued_notifications.where('trigger_at < ?, triggered = ?, ', Time.now, true) }.count
    
    total_notifications > 0 ? ((1 - (missed_notifications/total_notifications.to_f)) * 5) : 5
  end

  def self.certified
    LawFirm.joins(:form_submissions).where("form_submissions.created_at = (SELECT MAX(form_submissions.created_at) FROM form_submissions WHERE form_submissions.law_firm_id = law_firms.id) AND form_submissions.status='approved'")
  end
  def self.in_process
    LawFirm.joins(:form_submissions).where("form_submissions.created_at = (SELECT MAX(form_submissions.created_at) FROM form_submissions WHERE form_submissions.law_firm_id = law_firms.id) AND form_submissions.status='sent' OR  form_submissions.status='submitted' OR  form_submissions.status='started'")
  end
  def self.decertified
    LawFirm.joins(:form_submissions).where("form_submissions.created_at = (SELECT MAX(form_submissions.created_at) FROM form_submissions WHERE form_submissions.law_firm_id = law_firms.id) AND form_submissions.status='decertified' OR form_submissions.status='decline'")
  end
  def self.onboarded
    LawFirm.where('id NOT IN (SELECT DISTINCT(law_firm_id) FROM form_submissions)')
  end
end
