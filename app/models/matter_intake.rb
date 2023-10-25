class MatterIntake < ApplicationRecord

  has_paper_trail  
  acts_as_paranoid
  self.per_page = 10
  belongs_to :user
  belongs_to :law_firm
  belongs_to :matter_type
  belongs_to :lawyer, class_name: 'InternalLawyer', foreign_key: 'lawyer_id'
  belongs_to :requested_by, class_name: 'User', foreign_key: 'requested_by_id'
  belongs_to :line_of_business
  serialize :receive_personal_information_data_type, Array
  serialize :receive_general_business_data_type, Array
  serialize :applicable_technical_specialty_data_type, Array
  serialize :following_matter_involve, Array
  has_many :reviews, as: :reviewable
  has_many :invoices
  has_many :matter_approvals
  has_many :matter_intake_attachments, -> { where doc_type: 'attachment' }
  has_many :matter_intake_agreements, -> { where doc_type: 'agreement' }, class_name: 'MatterIntakeAttachment'
  has_many :external_lawyer_matter_intakes
  has_many :external_lawyers, :through => :external_lawyer_matter_intakes

  accepts_nested_attributes_for :invoices, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :matter_intake_attachments, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :matter_intake_agreements, reject_if: :all_blank, allow_destroy: true

  
  mount_uploader :asset, DocUploader

  validate :check_presence_of 

  before_save :convert_budget_amount

  #### validation for lob initiated starts ####
  # validates_presence_of :submitter_name, :name_of_matter_client, :matter_type_id, :matter_description, :following_matter_involve,
  #   :bmo_lawyer_name, :lob_contact_for_po, :cost_centre_for_legal_fees, :business_paying_for_matter, :jurisdiction,
  #   :group_paying_for_matter, :paying_entity, :outside_counsel_engaged, :is_syndicate_matter,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lobb" }

  # validates_presence_of :firm_type,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lobb" && matter_intake.outside_counsel_engaged === "Yes" }

  #   validates_presence_of :name_of_non_panel_firm,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lobb" && matter_intake.firm_type === "Non-Panel"  }

  # validates_presence_of :name_of_panel_firm,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lobb" && matter_intake.firm_type === "Panel"  }

  # validates_presence_of :name_of_panel_firm, :name_of_non_panel_firm,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lobb" && matter_intake.firm_type === "Panel & Non-Panel Firms"  }
  
  # #### validation for lob initiated ends ####

  # #### validation for lob initiated but for lawyer for Form-B starts ####
  
  # validates_presence_of :bmo_lawyer_name, :legal_group_of_bmo_lawyer, :work_area, :work_area_type, :is_conceal_imanage_workspace,
  #   :is_paper_file, :name_of_matter_client, :matter_description, :paying_entity, :type_of_price,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lobb" && Current.user && Current.user.role === "internal_lawyers" }

  # validates_presence_of :afa_details,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lobb" && Current.user && Current.user.role === "internal_lawyers" && matter_intake.is_alternative_fee_arrangement === "Yes" }

  # validates_presence_of :who_requires_access_to_imanage_workspace,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lobb" && Current.user && Current.user.role === "internal_lawyers" && matter_intake.is_conceal_imanage_workspace === "Yes" }

  #   validates_presence_of :is_ore_reportable, :is_otherwise_reportable,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.present? && matter_intake.user.role == "lobb" && Current.user && Current.user.role === "internal_lawyers" && matter_intake.work_area === "Regulatory" }
  # #### validation for lob initiated but for lawyer for Form-B ends ####

  # #### Validation common in General & Litigation intake starts ####

  # validates_presence_of :bmo_lawyer_name, :legal_group_of_bmo_lawyer, :work_area, :work_area_type, :is_syndicate_matter,
  #   :is_conceal_imanage_workspace, :name_of_matter_client, :matter_description, #:paying_entity, :is_paper_file,
  #   :business_paying_for_matter, :group_paying_for_matter, :jurisdiction, :outside_counsel_engaged,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && FORM_TYPE.include?(matter_intake.form_type) }

  # validates_presence_of :who_requires_access_to_imanage_workspace,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && FORM_TYPE.include?(matter_intake.form_type) && matter_intake.is_conceal_imanage_workspace === "Yes" }

  # validates_presence_of :following_matter_involve, :cost_centre_for_legal_fees, :lob_contact_for_po, :firm_type, :type_of_price,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && FORM_TYPE.include?(matter_intake.form_type) && matter_intake.outside_counsel_engaged != "N/A Internal – no law firm will be engaged" }
  
  # validates_presence_of :name_of_non_panel_firm,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && FORM_TYPE.include?(matter_intake.form_type) && matter_intake.firm_type === "Non-Panel"  }

  # validates_presence_of :name_of_panel_firm,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && FORM_TYPE.include?(matter_intake.form_type) && matter_intake.firm_type === "Panel"  }

  # validates_presence_of :name_of_panel_firm, :name_of_non_panel_firm,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && FORM_TYPE.include?(matter_intake.form_type) && matter_intake.firm_type === "Panel & Non-Panel Firms"  }

  # #### Validation common in General & Litigation intake starts ####

  # #### General Intake Lawyer Initiated validation starts ####

  # validates_presence_of :is_alternative_fee_arrangement,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && matter_intake.form_type === "general" && !TYPE_OF_PRICE.include?(matter_intake.type_of_price) }

  # validates_presence_of :afa_details,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && matter_intake.form_type === "general" && matter_intake.is_alternative_fee_arrangement === "Yes" }

  # #### General Intake Lawyer Initiated validation Ends ####

  # #### Litigation Intake Lawyer Initiated validation Starts ####

  # validates_presence_of :can_reimbursed_matter, :primary_issue, :allegation_of_employee_misconduct,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && matter_intake.form_type === "litigation" && matter_intake.outside_counsel_engaged != "N/A Internal – no law firm will be engaged" }
  
  # validates_presence_of :is_alternative_fee_arrangement,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && matter_intake.form_type === "litigation" && !TYPE_OF_PRICE.include?(matter_intake.type_of_price) }

  # validates_presence_of :afa_details,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && matter_intake.form_type === "litigation" && matter_intake.is_alternative_fee_arrangement === "Yes" }
  
  # validates_presence_of :is_ore_reportable, :is_otherwise_reportable,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && FORM_TYPE.include?(matter_intake.form_type) && matter_intake.work_area === "Regulatory" }

  # validates_presence_of :is_ore_reportable,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && matter_intake.form_type === "litigation" }
  
  # validates_presence_of :is_otherwise_reportable, :mi_matter, :nature_of_events, :process_type_level_1, :process_type_level_2, :product_type_level_1, :product_type_level_2,
  #   :event_type_level_1, :event_type_level_2, :business_activity_level_1, :business_activity_level_2,
  #   :if => Proc.new { |matter_intake| matter_intake.user_id.nil? && matter_intake.is_ore_reportable === "Yes" }
  
  #### Litigation Intake Lawyer Initiated validation Endss ####

  TYPE_OF_PRICE = ["Hourly Billing", "Work done at no cost"]

  FORM_TYPE = ["general", "litigation"]

  MATTER_STATUS = {
    "open": "Matter Open",
    "closed": "Matter Not Open"
  }
  
  HUMANIZED_ATTRIBUTES = {
    :name_of_matter_client => "Name of Matter/Client", 
    :matter_type_id => "Type of Matter",
    :following_matter_involve => "Will this matter involve the following",
    :mode_of_payment => "How will this law firm be paid",
    :lob_contact_for_po => "Name of PO approver",
    :business_paying_for_matter => "Business/Group paying for this matter (level 1)",
    :group_paying_for_matter => "Business/Group paying for this matter (level 2)",
    :work_area_type => "Work Area Level 2",
    :is_syndicate_matter => "Is this a syndicated matter",
    :is_conceal_imanage_workspace => "Conceal iManage Workspace",
    :is_paper_file => "Paper file",
    :firm_type => "Panel or Non-Panel Firm",
    :asset => "Document",
    :outside_counsel_engaged => "Engage External Counsel",
    :is_ore_reportable => "Should this matter be reported to Risk",
    :is_otherwise_reportable => "Is this matter otherwise reportable",
    :can_reimbursed_matter => "Could this matter be reimbursed"
  }

  RECEIVE_PERSONAL_INFORMATION_DATA_TYPE = ["Account/Card/Credit Card Information (i.e., account type/number, relationship, balances, transactions)","Contact Information (e.g., address, e-mail address, phone #)","Credit Score/History, Credit Bureau Report, Financial Profile Information","Customer Interactions (e.g., digital images, recorded conversations, branch visits)","Date of Birth","Employee Business Contact Information","Employee Identification Number(EIN)","Employee Performance Information (e.g., PPA, performance management)","Employee Personal Information (e.g., compensation, benefits)","Employee's Training Results","Gender, Ethnicity, Physical Attributes","Health Information, including information that is processed on behalf of commercial customers","Individual Authentication Credentials (e.g., password, PIN)","Individual's Name","Lists that include employee name and business contact information","National Personal Identification Number (e.g., Tax ID, SSN, SIN)","Opinions, Survey Responses","Other Financial Information (e.g., income verification, sourced from third parties)","Other Government Issued Personal Identification Number (e.g., driver's license, passport)","Technology Identifiers (e.g., Customer IP address, IMEI number, geolocation, device ID)","Social Media posts"]
  RECEIVE_GENERAL_BUSINESS_DATA_TYPE = ["Audit Report (Internal or Extneral)","Branch Directory","Business Continuity Plan (BCP)","Business Strategy, raw closing data, closing analysis, secret reports","Commonly Shared Internal Information (e.g., corporate policies/standards, guidelines, operating procedures, interoffice memos)","Credit Card Information (e.g., PAN, track data, EMV chip data)","External & Regulatory reporting","Financial forecast or results, prior to general or public disclosure","Financial Information Related to Revenue Generation (e.g., balance sheet, profit & loss figures)","Internal Phone Directory","Interviews with news media","Legal Contract Information","Marketing Brochure","Mergers, acquisitions, or divestitures, prior to general or public disclosure","Press Releases","Product Offerings (future), Product formulas methodology or calculations","Publish Annual Report (Incl. Financials)","Securities issuer information that is non-public and material","Strategic plans on mergers, acquisitions, or divestitures, prior to general or public disclosure","Trade Secrets","Trading Books","Transaction Information","Vendor/Third Party Information"]
  APPLICABLE_TECHNICAL_SPECIALTY_DATA_TYPE = ["Audit/System/Security Logs","Internal Bank IP Address, MAC Address, Hostname and Domain","Metadata","Patents, trademarks, copyrights","Private and symmetric cryptographic key and key parts","Proprietary processes, algorithms or systems","Public cryptographic key","Source Code","Sytem Documentation (e.g., design, functional specs, process, procedure, configuration data, etc.)","Documentation (e.g., design, functional specs, process, producedure, configuration, data, etc.)"]
  
  
  LOB_CONTACT_NAMES = [
    "Alan Elliott",
    "Julian Webb",
    "Jennie Montgomery",
    "Christina Harrison"
  ]

  MANDATORY_FIELDS = [:submitter_name, :name_of_matter_client, :matter_number, :requested_by_id, :matter_type_id, :line_of_business_id]

  def generate_type(type)
    case type
    when "dropdown"
      return "dropdown"
    when "autofill"
    when "text"
      return "text"
    end
  end

  def matter_form_role(current_user)
    is_bank_user =  current_user.role != "master_user" && current_user.role != "user"
    if current_user.role == "master_user" || current_user.role == "user" || current_user.role.blank?
      :law_firm
    else
      :bank
    end
  end

  def check_presence_of
    MANDATORY_FIELDS.each do |field|
      if send(field).blank?
        if field == :submitter_name
          errors.add(field, "is missing from profile. Please update submitter profile before creating matter.")
        else
          errors.add(field, "can't be blank")
        end
      end
    end
  end

  def generate_fields(current_user, current_tenant) 
    is_bank_user =  current_user.role != "master_user" && current_user.role != "user"
    is_law_firm =  current_user.role == "master_user" && current_user.role == "user"
    c_law_firm = (self.law_firm||current_user.law_firm)
    common_fields = [
      {
        name: I18n.t(:line_of_business_id, default: "Line of Business/Business group"),
        database_field: :line_of_business_id,
        access: {
          bank: "write",
          law_firm: "write"
        },
        type: "dropdown", # "dropdown" | "autofill" | "text" 
        optional: MANDATORY_FIELDS.include?(:line_of_business_id) == false,
        value: (self.line_of_business_id || current_user.line_of_businesses&.first&.id),
        collection: LineOfBusiness.where(tenant_id: current_tenant.id).map{|u| [u.name, u.id]}
      },
      {
        name: I18n.t(:submitter_name, default: "Submitter Name"),
        database_field: :submitter_name,
        access: {
          bank: "read",
          law_firm: "read"
        },
        type: "autofill", # "dropdown" | "autofill" | "text" 
        optional: MANDATORY_FIELDS.include?(:submitter_name) == false,
        value: (self.submitter_name||current_user.full_name),
        collection: [], # Static | From database | prefilled-value
      },
      {
        name: I18n.t(:name_of_matter_client, default: "Matter Name"),
        database_field: :name_of_matter_client,
        access: {
          bank: "write",
          law_firm: "write"
        },
        type: "text", # "dropdown" | "autofill" | "text" | "autocomplete"
        value: self.name_of_matter_client,
        optional: MANDATORY_FIELDS.include?(:name_of_matter_client) == false,
      },
      {
        name: I18n.t(:matter_number, default: "Matter Number"),
        database_field: :matter_number,
        access: {
          bank: "read",
          law_firm: "read"
        },
        type: "text", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:matter_number) == false,
        value: (self.matter_number||"MT-#{Date.today.month}-#{Date.today.day}-#{(1..999).to_a.sample}")
      },
      {
        name: I18n.t(:requested_by_id, default: "Requested by"),
        database_field: :requested_by_id,
        access: {
          bank: "write",
          law_firm: "write"
        },
        type: "dropdown", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:requested_by_id) == false,
        value: self.requested_by_id,
        collection: (current_tenant.users.where(role: ['lxp', 'lob', 'internal_lawyers'])+[current_user]).map{|u| [u.full_name, u.id]}
      },
      {
        name: I18n.t(:matter_type_id, default: "Matter Type"),
        database_field: :matter_type_id,
        access: {
          bank: "write",
          law_firm: "write"
        },
        type: "dropdown", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:matter_type_id) == false,
        value: self.matter_type_id,
        collection: MatterType.all.reject{|mt| mt.matter_type === "Litigation / Litiges"}.map{|mt| [mt.matter_type, mt.id] }
      },
      {
        name: I18n.t(:matter_description, default: "Matter Description"),
        database_field: :matter_description,
        access: {
          bank: "write",
          law_firm: "write"
        },
        type: "text", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:matter_description) == false,
        value: self.matter_description,
        collection: []
      },
      {
        name: I18n.t(:paying_entity, default: "Entity"),
        database_field: :paying_entity,
        access: {
          bank: "write",
          law_firm: "write"
        },
        type: "dropdown", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:paying_entity) == false,
        value: self.paying_entity,
        collection: MatterIntake::LegalEntity
      },
      {
        name: I18n.t(:other_party, default: "Other Party"),
        database_field: :other_party,
        access: {
          bank: "write",
          law_firm: "write"
        },
        type: "dropdown", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:other_party) == false,
        value: self.other_party,
        collection: MatterIntake::OtherParty
      },
      {
        name: I18n.t(:stage_of_litigation, default: "Litigation Stage"),
        database_field: :stage_of_litigation,
        access: {
          bank: "not_access",
          law_firm: "not_access"
        },
        type: "dropdown", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:stage_of_litigation) == false,
        value: self.stage_of_litigation,
        collection: MatterIntake::StageOfLitigation
      },
      {
        name: I18n.t(:primary_issue, default: "Issue"),
        database_field: :primary_issue,
        access: {
          bank: "write",
          law_firm: "write"
        },
        type: "dropdown", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:primary_issue) == false,
        value: self.primary_issue,
        collection: MatterIntake::PrimaryIssue
      },
      {
        name: I18n.t(:following_matter_involve, default: "Will this matter involve the following"),
        database_field: :following_matter_involve,
        access: {
          bank: "write",
          law_firm: "write"
        },
        type: "dropdown", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:following_matter_involve) == false,
        value: self.following_matter_involve,
        collection: MatterIntake::MatterInvolveFollowing,
        multiple: true
      },
      {
        name: I18n.t(:lawyer_id, default: "Internal (Bank) Responsible Lawyer"),
        database_field: :lawyer_id,
        access: {
          bank: "write",
          law_firm: "read"
        },
        type: "dropdown", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:lawyer_id) == false,
        value: self.lawyer_id,
        collection: InternalLawyer.where(tenant_id: current_tenant&.id).map {|il| [il.full_name, il.id]}
      },
      {
        name: I18n.t(:additional_comments_for_lrc_lawyer, default: "Additional Comments for Internal Lawyer"),
        database_field: :additional_comments_for_lrc_lawyer,
        access: {
          bank: "write",
          law_firm: "not_access"
        },
        type: "text", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:additional_comments_for_lrc_lawyer) == false,
        value: self.additional_comments_for_lrc_lawyer,
        collection: []
      },
      {
        name: I18n.t(:law_firm_id, default: "External Law firm"),
        database_field: :law_firm_id,
        access: {
          bank: "write",
          law_firm: "read"
        },
        type: "dropdown", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:law_firm_id) == false,
        value: self.law_firm_id,
        collection: Tenant.current.law_firms.where(law_firm_category: "PANEL").map{ |lf| [lf.name, lf.id] }
      },
      {
        name: I18n.t(:external_lawyer_ids, default: "Preferred Lawyer"),
        database_field: :external_lawyer_ids,
        access: {
          bank: "write",
          law_firm: "write"
        },
        type: "dropdown", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:external_lawyers) == false,
        value: self.external_lawyers&.ids,
        collection: (c_law_firm&.external_lawyers&.pluck(:name, :id)||[]),
        multiple: true
      },
      {
        name: I18n.t(:invoices, default: "Invoice (add/upload)"),
        database_field: :invoices,
        access: {
          bank: "write",
          law_firm: "write"
        },
        type: "autofill", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: true,
        value: self.invoices,
        collection: []
      },
      {
        name: I18n.t(:invoices, default: "Invoice - Approval"),
        database_field: :invoices,
        access: {
          bank: "write",
          law_firm: "not_access"
        },
        type: "autofill", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: true,
        value: self.invoices,
        collection: []
      },
      {
        name: I18n.t(:jurisdiction, default: "Jurisdiction"),
        database_field: :jurisdiction,
        access: {
          bank: "write",
          law_firm: "not_access"
        },
        type: "dropdown", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:jurisdiction) == false,
        value: self.jurisdiction,
        collection: MatterIntake::Jurisdiction
      },
      {
        name: I18n.t(:is_syndicate_matter, default: "Is this a syndicated matter?"),
        database_field: :is_syndicate_matter,
        access: {
          bank: "write",
          law_firm: "not_access"
        },
        type: "dropdown", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:is_syndicate_matter) == false,
        value: self.is_syndicate_matter,
        collection: [['Yes, we are the lead organization', 'Yes, we are the lead organization'],["Yes, we are not the lead organization", "Yes, we are not the lead organization"], ["No", "No"]]
      },
      {
        name: I18n.t(:afa_details, default: "AFA"),
        database_field: :afa_details,
        access: {
          bank: "write",
          law_firm: "read"
        },
        type: "text", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:afa_details) == false,
        value: self.afa_details,
        collection: []
      },
      {
        name: I18n.t(:budget_amount, default: "Fee Estimate / Budget"),
        database_field: :budget_amount,
        access: {
          bank: "write",
          law_firm: "write"
        },
        type: "currency", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:budget_amount) == false,
        value: self.budget_amount,
        collection: []
      },
      {
        name: I18n.t(:cost_centre_for_legal_fees, default: "Cost Centre (transit) for legal fees"),
        database_field: :cost_centre_for_legal_fees,
        access: {
          bank: "write",
          law_firm: "read"
        },
        type: "text", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:cost_centre_for_legal_fees) == false,
        value: self.cost_centre_for_legal_fees,
        collection: []
      },
      {
        name: I18n.t(:deal_code, default: "Deal Code (Capital Markets Only)"),
        database_field: :deal_code,
        access: {
          bank: "write",
          law_firm: "not_access"
        },
        type: "text", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:deal_code) == false,
        value: self.deal_code,
        collection: []
      },
      {
        name: I18n.t(:related_matter_number, default: "Related Matter Number"),
        database_field: :related_matter_number,
        access: {
          bank: "write",
          law_firm: "write"
        },
        type: "text", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:related_matter_number) == false,
        value: self.related_matter_number,
        collection: []
      },
      {
        name: I18n.t(:pii_involved, default: "Any PII involved in this matter?"),
        database_field: :pii_involved,
        access: {
          bank: "write",
          law_firm: "write"
        },
        type: "dropdown", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:pii_involved) == false,
        value: self.pii_involved,
        collection: [['True', true], ['False', false]]
      },
      {
        name: I18n.t(:can_reimbursed_matter, default: "Could law firm potentially receive sensitive information"),
        database_field: :can_reimbursed_matter,
        access: {
          bank: "write",
          law_firm: "not_access"
        },
        type: "dropdown", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:can_reimbursed_matter) == false,
        value: self.can_reimbursed_matter,
        collection: [['Yes', 'Yes'], ["No", "No"]]
      },
      {
        name: I18n.t(:is_ore_reportable, default: "Reportable Risk"),
        database_field: :is_ore_reportable,
        access: {
          bank: "write",
          law_firm: "not_access"
        },
        type: "dropdown", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:is_ore_reportable) == false,
        value: self.is_ore_reportable,
        collection: [['Yes', 'Yes'], ["No", "No"]]
      }
    ]

    optional_fields = [
      {
        name: I18n.t(:internal_file_number, default: "Internal File Number"),
        database_field: :internal_file_number,
        default_name: "Internal File Number",
        access: {
          bank: "write",
          law_firm: "read"
        },
        type: "text", # "dropdown" | "autofill" | "text" 
        optional: MANDATORY_FIELDS.include?(:internal_file_number) == false,
        value: self.internal_file_number,
        collection: [], # Static | From database | prefilled-value
    
      },
      {
        name: I18n.t(:business_department, default: "Business Department"),
        database_field: :business_department,
        default_name: "Business Department",
        access: {
          bank: "not_access",
          law_firm: "not_access"
        },
        type: "text", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:business_department) == false,
        value: self.business_department
      },
      {
        name: I18n.t(:business_group, default: "Business Group Responsible for Invoice"),
        database_field: :business_group,
        default_name: "Business Group Responsible for Invoice",
        access: {
          bank: "write",
          law_firm: "not_access"
        },
        type: "text", # "dropdown" | "autofill" | "text" | "autocomplete"
        optional: MANDATORY_FIELDS.include?(:business_group) == false,
        value: self.business_group
      }
    ]

    common_fields + optional_fields.select{|s| current_tenant.matter_optional_fields.include?(s[:default_name])}
  end

  LegalGroupBMOLawyer = [
    "Retail/Commercial",
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
    "AFRICA",
    "ASIA (NOT CHINA)",
    "ASIA PACIFIC & OCEANIA (NOT HONG KONG)",
    "BARBADOS",
    "BRAZIL",
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
    "Retail/Commercial",
    "Capital Markets",
    "Corporate",
    "Wealth Management"
  ]

  MatterBePaidOptions = [
    "Bank is paying",
    "Bank is paying and will be reimbursed by a third party/customer",
    "Third party/Customer paying law firm directly"
  ]

  LegalEntity = [
    "Laurentian Bank of Canada",
    "B2B Bank",
    "B2B Bank Financial Services Inc.",
    "B2B Bank Securities Services Inc.",
    "B2B Bank Intermediary Services Inc.",
    "B2B Trustco",
    "LBC Financial Services",
    "Laurentian Bank Securities Inc.",
    "LBC Capital Inc.",
    "Northpoint Commercial Finance",
    "Laurentian Trust of Canada Inc.",
    "LBC Trust",
    "LBC Investment Management Inc.",
    "Laurentian Bank Insurance Inc.",
    "LBC Tech Inc.",
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
    "Yes, organization pays",
    "Yes, customer/third party pays directly",
    "Yes, organization will be reimbursed by customer/third party",
    "No"
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
      description: "#{current_user.try(:full_name)} change matter status to : #{MatterIntake::MATTER_STATUS[self.status.upcase.to_sym]}" ,
      status: self.status.downcase
    )
  end

  def show_status
    if deleted_at.present?
      "Archived"
    elsif self.status === "awaiting_lxp_review"
      "Awaiting LXP Review"
    elsif self.status === "opened"
      "Open"
    else
      self.try(:status).try(:titleize)
    end
  end

  def following_matter_involve_to_s
    if following_matter_involve.class.name == 'Array'
      following_matter_involve.join(', ')
    else
      following_matter_involve
    end
  end

  def auto_approve_matter(current_user)
    if can_auto_approve?
      Review.create(
        actor_id: current_user.id,
        reviewable_type: self.class.to_s,
        reviewable_id: self.id,
        description: "Auto Approved by System" ,
        status: self.status.downcase
      )
      self.update_columns(status: 'opened')
      self.matter_approvals.where(status: ['pending', 'rejected']).delete_all
    end
  end

  def budget_amount_to_f
    self.budget_amount.to_s.gsub(/[$,]/,'').to_f
  end

  def can_auto_approve?
    ((self.show_status=='Submitted'||self.show_status=='Opened') &&
    self.budget_amount_to_f.present? &&
    self.budget_amount_to_f.to_i <= (Tenant.current&.auto_approve_amount_limit||500000) &&
    (Tenant.current&.auto_approve_matter_type||[]).include?(self.matter_type&.matter_type) &&
    self.consent_pending? == false
    )
  end

  def approval_pending?(current_user)
    current_user_pending_approval(current_user).present?
  end

  def current_user_pending_approval(current_user)
    return nil if (self.user_id == current_user.id) || (current_user.role == 'internal_lawyers' && self.lawyer_id != current_user.id)
    if Tenant.current.approval_process == 'serial'
      obj = self.approval_listing.where(status: ['pending', 'rejected']).order(:approval_sequence).last
      obj.present? && obj.approve_by_role == current_user.role ? obj : nil
    else
      approval_listing.where(status: ['pending', 'rejected'], approve_by_role: current_user.role).last
    end
  end

  def send_notification_for_matter_open(role)
    if role == 'lxp'
      MatterIntakeMailer.send_notification_to_lxp_for_matter_open(self).deliver_now
    elsif role == 'master_user'
      MatterIntakeMailer.send_notification_to_law_firm_for_matter_open(self).deliver_now
    elsif role == 'internal_lawyers'
      MatterIntakeMailer.send_notification_to_lawyer_for_matter_open(self).deliver_now
    end
  end

  def approval_listing
    if consent_pending?
      matter_approvals.where(approval_type: 'consent')
    else
      matter_approvals
    end
  end

  def consent_pending?
    matter_approvals.where(approval_type: 'consent', status: ['pending', 'rejected']).present?
  end

  def convert_budget_amount
    if budget_amount.present?
      self.budget_amount = budget_amount_to_f
    end
  end

  def set_default_approval_status(current_user)
    if Tenant.current.present? && status == 'submitted'
      Review.create(
        actor_id: current_user&.id,
        reviewable_type: self.class.to_s,
        reviewable_id: self.id,
        description: "Auto Approved by #{current_user.try(:full_name)}" ,
        status: self.status.downcase
      )
      notfiy_roles = []
      Tenant.current.tenant_matter_approvals.each do |matter_approval|
        if matter_approval.role.present?
          if matter_approval.approval.present?
            if matter_approval.owner_role == current_user.role
              puts "****"
              puts matter_approval.inspect
              approval_sequence = Tenant.current.approval_process == 'serial' ? matter_approval.sequence_number : 0
              MatterApproval.create_matter_approval(self.id, matter_approval.role, matter_approval.approval_type, approval_sequence)
            end
          end
          if matter_approval.notification.present?
            notfiy_roles << matter_approval.role
          end
        end
      end
      notfiy_roles.uniq.each do |role|
        send_notification_for_matter_open(role)
      end
    end
  end
end
