class MatterIntake < ApplicationRecord

  self.per_page = 10
  belongs_to :user
  belongs_to :law_firm
  belongs_to :matter_type
  belongs_to :lawyer, class_name: 'InternalLawyer', foreign_key: 'lawyer_id'

  has_many :reviews, as: :reviewable

  mount_uploader :asset, DocUploader

  #### validation for lob initiated starts ####
  validates_presence_of :submitter_name, :name_of_matter_client, :matter_type_id, :matter_description, :following_matter_involve,
    :bmo_lawyer_name, :lob_contact_for_po, :cost_centre_for_legal_fees, :business_paying_for_matter, :jurisdiction,
    :group_paying_for_matter, :paying_entity, :outside_counsel_engaged,
    :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lob" }

  validates_presence_of :firm_type,
    :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lob" && matter_intake.outside_counsel_engaged === "Yes" }

    validates_presence_of :name_of_non_panel_firm,
    :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lob" && matter_intake.firm_type === "Non-Panel"  }

  validates_presence_of :name_of_panel_firm,
    :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lob" && matter_intake.firm_type === "Panel"  }

  validates_presence_of :name_of_panel_firm, :name_of_non_panel_firm,
    :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lob" && matter_intake.firm_type === "Panel & Non-Panel Firms"  }
  
  #### validation for lob initiated ends ####

  #### validation for lob initiated but for lawyer for Form-B starts ####
  
  validates_presence_of :bmo_lawyer_name, :legal_group_of_bmo_lawyer, :work_area, :work_area_type, :is_syndicate_matter, :is_conceal_imanage_workspace,
    :is_paper_file, :name_of_matter_client, :matter_description, :paying_entity,
    :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lob" && Current.user && Current.user.role === "internal_lawyers" }

  validates_presence_of :afa_details,
    :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lob" && Current.user && Current.user.role === "internal_lawyers" && matter_intake.is_alternative_fee_arrangement === "Yes" }

  validates_presence_of :who_requires_access_to_imanage_workspace,
    :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lob" && Current.user && Current.user.role === "internal_lawyers" && matter_intake.is_conceal_imanage_workspace === "Yes" }

    validates_presence_of :is_ore_reportable, :is_otherwise_reportable,
    :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lob" && Current.user && Current.user.role === "internal_lawyers" && matter_intake.work_area === "Regulatory" }
  #### validation for lob initiated but for lawyer for Form-B ends ####

  #### Validation common in General & Litigation intake starts ####

  validates_presence_of :bmo_lawyer_name, :legal_group_of_bmo_lawyer, :work_area, :work_area_type, :is_syndicate_matter,
    :is_conceal_imanage_workspace, :is_paper_file, :name_of_matter_client, :matter_description, :paying_entity,
    :business_paying_for_matter, :group_paying_for_matter, :jurisdiction, :outside_counsel_engaged,
    :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && FORM_TYPE.include?(matter_intake.form_type) }

  validates_presence_of :who_requires_access_to_imanage_workspace,
    :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && FORM_TYPE.include?(matter_intake.form_type) && matter_intake.is_conceal_imanage_workspace === "Yes" }

  validates_presence_of :following_matter_involve, :cost_centre_for_legal_fees, :lob_contact_for_po, :firm_type, :type_of_price,
    :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && FORM_TYPE.include?(matter_intake.form_type) && matter_intake.outside_counsel_engaged != "N/A Internal – no law firm will be engaged" }
  
  validates_presence_of :name_of_non_panel_firm,
    :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && FORM_TYPE.include?(matter_intake.form_type) && matter_intake.firm_type === "Non-Panel"  }

  validates_presence_of :name_of_panel_firm,
    :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && FORM_TYPE.include?(matter_intake.form_type) && matter_intake.firm_type === "Panel"  }

  validates_presence_of :name_of_panel_firm, :name_of_non_panel_firm,
    :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && FORM_TYPE.include?(matter_intake.form_type) && matter_intake.firm_type === "Panel & Non-Panel Firms"  }

  #### Validation common in General & Litigation intake starts ####

  #### General Intake Lawyer Initiated validation starts ####

  validates_presence_of :is_alternative_fee_arrangement,
    :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && matter_intake.form_type === "general" && !TYPE_OF_PRICE.include?(matter_intake.type_of_price) }

  validates_presence_of :afa_details,
    :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && matter_intake.form_type === "general" && matter_intake.is_alternative_fee_arrangement === "Yes" }

  #### General Intake Lawyer Initiated validation Ends ####

  #### Litigation Intake Lawyer Initiated validation Starts ####

  validates_presence_of :can_reimbursed_matter, :primary_issue, :allegation_of_employee_misconduct,
    :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && matter_intake.form_type === "litigation" && matter_intake.outside_counsel_engaged != "N/A Internal – no law firm will be engaged" }
  
  validates_presence_of :is_alternative_fee_arrangement,
    :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && matter_intake.form_type === "litigation" && !TYPE_OF_PRICE.include?(matter_intake.type_of_price) }

  validates_presence_of :afa_details,
    :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && matter_intake.form_type === "litigation" && matter_intake.is_alternative_fee_arrangement === "Yes" }
  
  validates_presence_of :is_ore_reportable, :is_otherwise_reportable,
    :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && FORM_TYPE.include?(matter_intake.form_type) && matter_intake.work_area === "Regulatory" }

  validates_presence_of :is_ore_reportable,
    :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && matter_intake.form_type === "litigation" }
  
  validates_presence_of :is_otherwise_reportable, :mi_matter, :nature_of_events, :process_type_level_1, :process_type_level_2, :product_type_level_1, :product_type_level_2,
    :event_type_level_1, :event_type_level_2, :business_activity_level_1, :business_activity_level_2,
    :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && matter_intake.form_type === "litigation" && matter_intake.is_ore_reportable === "Yes" }
  
  #### Litigation Intake Lawyer Initiated validation Endss ####

  TYPE_OF_PRICE = ["Hourly Billing", "Work done at no cost"]

  FORM_TYPE = ["general", "litigation"]

  HUMANIZED_ATTRIBUTES = {
    :name_of_matter_client => "Name of Matter/Client", 
    :matter_type_id => "Type of Matter",
    :following_matter_involve => "Will this matter involve the following",
    :mode_of_payment => "How will this law firm be paid",
    :lob_contact_for_po => "Name of PO approver",
    :business_paying_for_matter => "Business/Group paying for this matter (level 1)",
    :group_paying_for_matter => "Business/Group paying for this matter (level 2)",
    :work_area_type => "Work Area Level 2",
    :is_syndicate_matter => "Is this a syndicate matter",
    :is_conceal_imanage_workspace => "Conceal iManage Workspace",
    :is_paper_file => "Paper file",
    :firm_type => "Panel or Non-Panel Firm",
    :asset => "Document",
    :outside_counsel_engaged => "Is outside counsel being engaged",
    :is_ore_reportable => "Is this matter ORE reportable",
    :is_otherwise_reportable => "Is this matter otherwise reportable",
    :can_reimbursed_matter => "Could this matter be reimbursed"
  }

  LOB_CONTACT_NAMES = [
    "Alan Elliott",
    "Julian Webb",
    "Jennie Montgomery",
    "Christina Harrison"
  ]

  LegalGroupBMOLawyer = [
    "Canadian P&C",
    "Capital Markets",
    "Corporate Affairs",
    "Regulatory",
    "Technology & Operations",
    "Wealth Management"
  ]

  WorkArea = [
    "Contractual Transactions (non-lending)",
    "Corporate Governance",
    "Employment (non-action)",
    "General Customer Inquiries",
    "Intellectual Property",
    "Legal Administration",
    "Lending & Financing (inc. Secured Transactions and Workouts)",
    "M&A",
    "Marketing",
    "New Products",
    "Real Estate",
    "Regulatory",
    "Tax",
    "Wills/Estates"
  ]

  WorkAreaLitigation = [
    "Employment (non-action)",
    "Legal Administration",
    "Litigation",
    "Regulatory"
  ]

  Jurisdiction = [
    "AFRICA",
    "ASIA (NOT CHINA)",
    "ASIA PACIFIC & OCEANIA (NOT HONG KONG)",
    "BARBADOS",
    "BRAZIL",
    "CANADA",
    "CANADA - ALBERTA",
    "CANADA - BRITISH COLUMBIA",
    "CANADA - MANITOBA",
    "CANADA - NEW BRUNSWICK",
    "CANADA - NEWFOUNDLAND AND LABRADOR",
    "CANADA - NORTHWEST TERRITORIES",
    "CANADA - NOVA SCOTIA",
    "CANADA - NUNAVUT",
    "CANADA - ONTARIO",
    "CANADA - PRINCE EDWARD ISLAND",
    "CANADA - QUEBEC",
    "CANADA - SASKATCHEWAN",
    "CANADA - YUKON",
    "CENTRAL AMERICA",
    "CHINA",
    "EUROPE (NOT UK OR IRELAND)",
    "HONG KONG",
    "IRELAND",
    "MENA (MIDDLE EAST & NORTH AFRICA)",
    "NORTH AMERICA",
    "OTHER INTERNATIONAL",
    "SOUTH AMERICA (NOT BRAZIL)",
    "UNITED KINGDOM",
    "UNITED STATES",
    "UNITED STATES - ALABAMA",
    "UNITED STATES - ALASKA",
    "UNITED STATES - ARIZONA",
    "UNITED STATES - ARKANSAS",
    "UNITED STATES - CALIFORNIA",
    "UNITED STATES - COLORADO",
    "UNITED STATES - CONNECTICUIT",
    "UNITED STATES - DELAWARE",
    "UNITED STATES - FLORIDA",
    "UNITED STATES - GEORGIA",
    "UNITED STATES - HAWAII",
    "UNITED STATES - IDAHO",
    "UNITED STATES - ILLINOIS",
    "UNITED STATES - INDIANA",
    "UNITED STATES - IOWA",
    "UNITED STATES - KANSAS",
    "UNITED STATES - KENTUCKY",
    "UNITED STATES - LOUISIANA",
    "UNITED STATES - MAINE",
    "UNITED STATES - MARYLAND",
    "UNITED STATES - MASSACHUSETTS",
    "UNITED STATES - MICHIGAN",
    "UNITED STATES - MINNESOTA",
    "UNITED STATES - MISSISSIPPI",
    "UNITED STATES - MISSOURI",
    "UNITED STATES - MONTANA",
    "UNITED STATES - NEBRASKA",
    "UNITED STATES - NEVADA",
    "UNITED STATES - NEW HAMPSHIRE",
    "UNITED STATES - NEW JERSEY",
    "UNITED STATES - NEW MEXICO",
    "UNITED STATES - NEW YORK",
    "UNITED STATES - NORTH CAROLINA",
    "UNITED STATES - NORTH DAKOTA",
    "UNITED STATES - OHIO",
    "UNITED STATES - OKLAHOMA",
    "UNITED STATES - OREGON",
    "UNITED STATES - PENNSYLVANIA",
    "UNITED STATES - RHODE ISLAND",
    "UNITED STATES - SOUTH CAROLINA",
    "UNITED STATES - SOUTH DAKOTA",
    "UNITED STATES - TENNESSEE",
    "UNITED STATES - TEXAS",
    "UNITED STATES - UTAH",
    "UNITED STATES - VERMONT",
    "UNITED STATES - VIRGINIA",
    "UNITED STATES - WASHINGTON",
    "UNITED STATES - WASHINGTON D.C.",
    "UNITED STATES - WEST VIRGINIA",
    "UNITED STATES - WISCONSIN",
    "UNITED STATES - WYOMING"
  ]

  Business = [
    "Canadian P&C",
    "Capital Markets",
    "Corporate",
    "U.S. P&C",
    "Wealth Management"
  ]

  MatterBePaidOptions = [
    "BMO is paying",
    "BMO is paying and will be reimbursed by a third party/customer",
    "Third party/Customer paying law firm directly"
  ]

  LegalEntity = [
    "Bank of Montreal",
    "BMO Assurance",
    "BMO Capital Markets",
    "BMO Harris",
    "BMO Invest",
    "BMO Investorline",
    "BMO Nesbitt CAD",
    "BMO Trust Company",
    "BMO USD"
  ]

  TypeOfPrice = [
    "Hourly Billing",
    "Cap and Collar",
    "Capped Fee",
    "Fixed Fee and Collar",
    "Fixed Fee by Matter",
    "Fixed Fee by Phase",
    "Monthly Retainer Fee",
    "Success Fee",
    "Work done at no cost"
  ]

  OtherParty = [
    "Borrower",
    "Counterparty",
    "Defendant",
    "Guarantor",
    "Opposing Party",
    "Plaintiff",
    "Vendor"
  ]

  FirmType = ['Panel', 'Non-Panel', 'Panel & Non-Panel Firms']

  OutsideCounselEngaged = [
    "Yes, bank pay",
    "Yes, third party/customer paying law firm directly",
    "Yes, BMO is paying and will be reimbursed by a third party/customer",
    "N/A Internal – no law firm will be engaged"
  ]

  StageOfLitigation = [
    "Preliminary (Pre-pleading) Stage/Motions",
    "Pleadings",
    "Discovery",
    "Dispositive Motions (Motion to strike/dismiss, summary judgment)",
    "Class Certification",
    "Mediation",
    "Trial",
    "Appeal",
    "Stayed/Dormant"
  ]

  PrimaryIssue = [
    "Account Agreement Dispute (Inc. Trading)",
    "Account Management/Performance (Inc. Losses)",
    "Advice (Inc. Tax and Investment)",
    "Breach of Fiduciary Duty",
    "Collections",
    "Collusion (Inc. Anti-trust Issues)",
    "Conflict of Interest",
    "Construction Liens",
    "Consumer Legislation Violations",
    "Contractual Disputes",
    "Conversion",
    "Creditor Insurance",
    "Demarketing",
    "Discrimination/Harassment",
    "Dismissal (Wrongful and Constructive)",
    "Disputed Fees/Charges/Comm",
    "Environmental",
    "Estates/POA",
    "Ethics/Code of Conduct",
    "Fraud/Theft (Inc. Forgery)",
    "Insolvency",
    "Insurance (Inc. Disability)",
    "IP-Trademarks/Patents/Copyrights Claims",
    "KYC/Suitability",
    "Lender Liability",
    "Misrepresentation",
    "Negligence",
    "Privacy/Information Claims",
    "Prospectus/Offering Misrepresentation",
    "Regulatory Issues (Inc. Policies and Procedures)",
    "Restrictive Covenants/Confidentiality Agreements",
    "Sanctions/AML Regulations",
    "Supervision",
    "Trading Issues/Disputes (Inc. FX, Interest)"
  ]

  SecondaryIssue = [
    "Account Agreement Dispute (Inc. Trading)",
    "Account Management/Performance (Inc. Losses)",
    "Advice (Inc. Tax and Investment)",
    "Breach of Fiduciary Duty",
    "Collections",
    "Collusion (Inc. Anti-trust Issues)",
    "Conflict of Interest",
    "Construction Liens",
    "Consumer Legislation Violations",
    "Contractual Disputes",
    "Conversion",
    "Creditor Insurance",
    "Demarketing",
    "Discrimination/Harassment",
    "Dismissal (Wrongful and Constructive)",
    "Disputed Fees/Charges/Comm",
    "Environmental",
    "Estates/POA",
    "Ethics/Code of Conduct",
    "Fraud/Theft (Inc. Forgery)",
    "Insolvency",
    "Insurance (Inc. Disability)",
    "IP-Trademarks/Patents/Copyrights Claims",
    "KYC/Suitability",
    "Lender Liability",
    "Misrepresentation",
    "Negligence",
    "Privacy/Information Claims",
    "Prospectus/Offering Misrepresentation",
    "Regulatory Issues (Inc. Policies and Procedures)",
    "Restrictive Covenants/Confidentiality Agreements",
    "Sanctions/AML Regulations",
    "Supervision",
    "Trading Issues/Disputes (Inc. FX, Interest)"
  ]

  BMOParty = [
    "Defendant",
    "Plaintiff",
    "Third Party Defendant",
    "Third Party Plaintiff",
    "Co-Defendant",
    "Non-Party"
  ]

  Region = [
    "British Columbia & Yukon",
    "Prairies Central (incl. Ontario Northern Getaway and North Western Ontario)",
    "Greater Ontario (incl. Peterborough, Kingston, Greater Lakelands and surrounding areas)",
    "Greater Toronto (incl. Durham and Barrie)",
    "Quebec & Eastern Ontario (incl. National Capital Region, Ottawa Valley and Seaway)",
    "Atlantic Provinces",
    "Headquarters",
    "Specialized Sales Group (SSG)"
  ]

  AmountCurrency = [
    "CAD",
    "USD",
    "AUD",
    "GBP",
    "CHF",
    "EUR"
  ]

  CourtType = [
    "ADR",
    "Federal",
    "Non-US",
    "Regulatory / Admin",
    "State"
  ] 

  ComsetIssues = [
    "Adequacy of books and records",
    "Churning and excessive trading",
    "Client priority rule violations",
    "Conflict of interest",
    "Failure to execute orders",
    "Failure to follow client instructions",
    "Falsification/forgery of documents",
    "Inappropriate personal financial dealings",
    "Insider trading/self dealing",
    "Internal control violations",
    "Investment advice",
    "Losses",
    "Manipulation and wash trading",
    "Misrepresentation",
    "Money laundering",
    "Prospectus, exemptions and related matters",
    "Supervision",
    "Theft or fraud",
    "Trading outside jurisdiction",
    "Transfer of accounts",
    "Unauthorized or discretionary trading",
    "Unsuitable investments",
    "Violation of commission or other SRO's order",
    "Violation of IIROC order",
    "Other"
  ]

  ProcessTypeLevel1 = [
    "Capture and Document Transactions",
    "Deliver Products and Services",
    "Develop, Design and Maintain Products, Services and General Business Capabilities",
    "Market Products and Services",
    "Sell/Reach Agreement to Conduct Specific Business",
    "Take on and Maintain Clients/Customers, Counterparties and Trade Relationships",
    "Perform Settlements and Closing Activities",
    "Perform Transaction Accounting",
    "Manage Human Resources",
    "Manage Information Technology",
    "Manage Financial Reporting and Taxation",
    "Manage Capital, Funding and Liquidity",
    "Manage Suppliers and Outsourcing Service Suppliers",
    "Manage Physical Assets and Facilities",
    "Manage Compliance, Legal, Governance and Audit",
    "Manage Risk Systems"
  ]

  ProcessTypeLevel2 = [
    'Option1',
    'Option2',
    'Option3'
  ]

  ProductTypeLevel1 = [
    "Capital Raising",
    "Corporate Finance Services",
    "Retail Credit",
    "Commercial Credit",
    "Deposits",
    "Cash Management, Payments and Settlements",
    "Trust/Investment Management",
    "Investment Products",
    "Brokerage",
    "Not Product Related",
    "Non-Banking Product"
  ]

  EventTypeLevel1 = [
    "Internal Fraud",
    "External Fraud",
    "Employment Practices and Workplace Safety",
    "Clients, Products and Business Practices",
    "Disasters and Public Safety",
    "Technology and Infrastructure Failures",
    "Execution, Delivery and Process Management"
  ]

  BusinessActivityLevel1 = [
    "Corporate Finance",
    "Trading and Sales",
    "Retail Banking",
    "Commercial Banking",
    "Clearing",
    "Agency Services",
    "Asset Management",
    "Retail Brokerage",
    "Private Banking",
    "Corporate Areas",
    "Insurance",
    "Card Services",
    "Branch Banking"
  ]

  MatterInvolveFollowing = [
    "Combination of confidential information with over 10,000 records",
    "Combination of sensitive and confidential information with over 10,000 records",
    "Litigation",
    "Merger/Acquisition",
    "Personal Identifiable Information > 10,000 records",
    "None of the above"
  ]

  # For overriding fields name in error messages
  def self.human_attribute_name(attribute, options = {})
    HUMANIZED_ATTRIBUTES[attribute.to_sym] || super
  end

  def send_notification_to_lawyer
    MatterIntakeMailer.send_notification_to_lawyer_for_form_submission(self).deliver_now
  end

  def send_notification_to_lxp
    MatterIntakeMailer.send_notification_to_lxp_for_form_submission(self).deliver_now
  end

  def send_notification_litigation_specialist_team
    if self.email_notification_to_litigation_specialist_team
      MatterIntakeMailer.send_notification_litigation_specialist_team(self).deliver_now
    end
  end

  def send_notification_to_lawyer_and_lxp
    MatterIntakeMailer.send_notification_to_lxp_for_matter_open(self).deliver_now
    MatterIntakeMailer.send_notification_to_lawyer_for_matter_open(self).deliver_now
  end

  def send_notification_to_lawyer_form_needs_updation
    MatterIntakeMailer.send_notification_to_lawyer_form_needs_updation(self).deliver_now
  end

  def add_log_for_lawyer_submission_to_lxp(current_user)
    Review.create(
      actor_id: current_user.id,
      reviewable_type: self.class.to_s,
      reviewable_id: self.id,
      description: "#{self.lawyer.try(:full_name)} submitted matter intake form for LXP review.",
      status: "awaiting_lxp_review"
    )
  end

  def add_log_for_lxp_rejects_and_returns_to_lawyer(current_user)
    Review.create(
      actor_id: current_user.id,
      reviewable_type: self.class.to_s,
      reviewable_id: self.id,
      description: "#{current_user.try(:full_name)} returned to lawyer for update.",
      status: "awaiting_lawyer_update"
    )
  end

  def add_log_matter_open_by_lxp(current_user)
    Review.create(
      actor_id: current_user.id,
      reviewable_type: self.class.to_s,
      reviewable_id: self.id,
      description: "#{current_user.try(:full_name)} opened matter in T360 with matter number: #{self.matter_number}.",
      status: "matter_open"
    )
  end

  def show_status
    if self.status === "awaiting_lxp_review"
      "Awaiting LXP Review"
    else
      self.try(:status).try(:titleize)
    end
  end

end
