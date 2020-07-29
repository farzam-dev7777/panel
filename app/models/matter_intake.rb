class MatterIntake < ApplicationRecord

  self.per_page = 10
  belongs_to :user
  belongs_to :law_firm
  belongs_to :matter_type
  belongs_to :lawyer, class_name: 'InternalLawyer', foreign_key: 'lawyer_id'

  has_many :reviews, as: :reviewable

  # For common fields 
  validates_presence_of :bmo_lawyer_name, :name_of_matter_client, :matter_description, :paying_entity,
    :business_paying_for_matter, :group_paying_for_matter, :following_matter_involve, :mode_of_payment,
    :lob_contact_for_po, :cost_centre_for_legal_fees

  # validation for lob initiated
  validates_presence_of :submitter_name, :lob_contact_name, :matter_type_id,
    :law_firm_id, :additional_comments_for_lrc_lawyer,
    :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lob" }

  # validation for lawyer initiated
  validates_presence_of :legal_group_of_bmo_lawyer, :work_area, :work_area_type,
    :jurisdiction, :outside_counsel_engaged, :firm_type,
    :if => Proc.new { |matter_intake| matter_intake.user_id.nil? }

  HUMANIZED_ATTRIBUTES = {
    :name_of_matter_client => "Name of Matter/Client", 
    :matter_type_id => "Type of Matter",
    :following_matter_involve => "Will this matter involve the following",
    :mode_of_payment => "How will this law firm be paid",
    :lob_contact_for_po => "LOB contact to approve PO",
    :business_paying_for_matter => "Business/Group paying for this matter (level 1)",
    :group_paying_for_matter => "Business/Group paying for this matter (level 2)",
    :work_area_type => "Work Area Level 2",
    :is_syndicate_matter => "Is this a syndicate matter",
    :is_conceal_imanage_workspace => "Conceal iManage Workspace",
    :is_paper_file => "Paper file",
    :firm_type => "Panel or Non-Panel Firm"
  }

  LOB_CONTACT_NAMES = [
    "Alan Elliott",
    "Julian Webb",
    "Jennie Montgomery",
    "Christina Harrison"
  ]

  LegalGroupBMOLawyer = [
    "Capital Markets",
    "Canadian P&C",
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
    "A third party or BMO’s customer is paying",
    "BMO is paying",
    "BMO is paying but will be reimbursed by a third party or BMO’s customer"
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
    "Yes, BMO is paying and will not be reimbursed",
    "Yes, a third party or BMO’s customer is paying",
    "Yes, BMO is paying but will be reimbursed by a third party or BMO’s customer",
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
      status: "waiting_for_lxp_review"
    )
  end

  def add_log_for_lxp_rejects_and_returns_to_lawyer(current_user)
    Review.create(
      actor_id: current_user.id,
      reviewable_type: self.class.to_s,
      reviewable_id: self.id,
      description: "#{current_user.try(:full_name)} rejects matter intake form and retuns to lawyer for completion/updation.",
      status: "waiting_for_lawyer_updation"
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

end
