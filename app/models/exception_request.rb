class ExceptionRequest < ApplicationRecord

  #serialize :matter_types, Array

  self.per_page = 10
  belongs_to :user
  belongs_to :law_firm
  has_many :activity_logs
  has_many :reviews, as: :reviewable
  serialize :reason, Array
  serialize :receive_personal_information_data_type, Array
  serialize :receive_general_business_data_type, Array
  serialize :applicable_technical_specialty_data_type, Array

  LOB_LIST = ["Canadian P&C / Services bancaires Particuliers et entreprises - Canada","Capital Markets / Marché des capitaux","Corporate / Services d'entreprise","Technology & Operations / Technologie et opérations (T&O)","US P&C / Services bancaires Particuliers et entreprises - É.-U.","Wealth Management / Gestion de patrimonie"]
  REQUEST_TYPE = {
    "EXCEPTION": "Exception",
    "ADD_TO_LAW_FIRM_PANEL": "Add to Law Firm Panel"
  }
  LAW_FIRM_CATEGORIES = {
    "PANEL": "Panel",
    "NON_PANEL": "Non Panel"
  }

  MATTER_TYPES = [
    "Contractual Transactions (non-lending) / Traduction contractuelle (autre que des prêt",
    "Corporate Governance / Gouvernance d'entreprise",
    "Employment (non-action) / Recrutement (aucune intervention)",
    "General Customer Inquiries / Questions générales de clients",
    "Lending and Financing (inc. secured transactions and workouts) / Financement de prê transactions garanties et les redressements)",
    "Litigation / Litiges",
    "Mergers & Acquisitions / Fusions et acquisitions",
    "New Products / Nouveaux produits",
    "Real Estate (non-lending) / Immobilier (autres que des prêts)",
    "Regulatory / Réglementation",
    "Tax / Fiscalité",
    "Trademarks / Marques",
    "Wills & Estates / Testaments/successions"
  ]
  MINORITY_OWNED_TYPE = ["Yes", "No"]
  WOMEN_OWNED_TYPE = ["Yes", "No"]

  EXCEPTION_REQUEST_REASON = ["Expertise", "Cost", "Designated Counsel", "Location", "Customer directed"]
  EXCEPTION_REQUEST_PAYER =  [["Bank Pay", "Bank Pay"], ["Customer paying law firm directly", "Customer Pay"], ["Bank paying and customer reimbursing BMO", "Bank paying and customer reimbursing BMO"]]
  INVOLVED_ENGAGEMENT = [
    "Merger/Acquisition",
    "Litigation",
    "Personam Identifiable information > 10,000 records",
    "Combination of confidential information with over 10,000 records",
    "None of the above"
  ]

  MODE_OF_PAYMENT = ["Bank Pay", "Remuneration par la Banque"]

  MATTER_INVOLE_FOLLOWING = [
    "Merger/Acquisition",
    "Litigation",
    "Personal Identifiable Information > 10,000 records",
    "Combination of sensitive and confidential information with over 10,000 records",
    "Combination of confidential information with over 10,000 records",
    "None of the above"
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
  # validates_presence_of :requested_by, :submitted_by_email, :line_of_business, :lob_contact_name, :minority_owned, :women_owned, :matter_name

  belongs_to :law_firm

  def status_for_lob
    status = ""
    if self.lxp_status === 'APPROVED'
      status = "APPROVED"
    end
    status
  end

  def can_user_change_status?(current_user)
    
    if self.internal_lawyers_status === "REJECTED"
      self.internal_lawyers_status != 'APPROVED'  
    elsif self.internal_lawyers_status === "APPROVED"
      self.lxp_status != 'REJECTED'
    elsif current_user.role === 'lxp' 
      self.lxp_status != 'APPROVED'
    elsif current_user.role === 'internal_lawyers'
      self.internal_lawyers_status != 'APPROVED'
    end
  end

  EXCEPTION_REQUEST_STATUS = {
    "REQUEST_TO_INPUT": "Lawyer Input Requested",
    "APPROVED": "Approved",
    "REJECTED": "Rejected"
  }

  EXCEPTION_REQUEST_STATUS2 = {
    "REQUEST_TO_INPUT": "Lawyer Input Requested",
    "APPROVED": "Approved",
    "REJECTED": "Rejected",
    "REVIEWED_BY_LAWYER": "Reviewed by Lawyer",
    "reviewed_by_lawyer": "Reviewed by Lawyer"
  }

  EXCEPTION_REQUEST_STATUS_LAWYER= {
    "": "Select",
    "APPROVED": "Approved",
    "REJECTED": "Rejected"
  }
  
  EXCEPTION_REQUEST_PAY_TYPE = {
    "BANK_PAY": "Bank Pay",
    "THIRD_PAARTY_PAY": "Third Party Pay"
  }

  RECEIVE_PERSONAL_INFORMATION_DATA_TYPE = ["Account/Card/Credit Card Information (i.e., account type/number, relationship, balances, transactions)","Contact Information (e.g., address, e-mail address, phone #)","Credit Score/History, Credit Bureau Report, Financial Profile Information","Customer Interactions (e.g., digital images, recorded conversations, branch visits)","Date of Birth","Employee Business Contact Information","Employee Identification Number(EIN)","Employee Performance Information (e.g., PPA, performance management)","Employee Personal Information (e.g., compensation, benefits)","Employee's Training Results","Gender, Ethnicity, Physical Attributes","Health Information, including information that is processed on behalf of commercial customers","Individual Authentication Credentials (e.g., password, PIN)","Individual's Name","Lists that include employee name and business contact information","National Personal Identification Number (e.g., Tax ID, SSN, SIN)","Opinions, Survey Responses","Other Financial Information (e.g., income verification, sourced from third parties)","Other Government Issued Personal Identification Number (e.g., driver's license, passport)","Technology Identifiers (e.g., Customer IP address, IMEI number, geolocation, device ID)","Social Media posts"]
  RECEIVE_GENERAL_BUSINESS_DATA_TYPE = ["Audit Report, internal or external","Branch Directory","Business Continuity Plan (BCP)","Business Strategy, raw closing data, closing analysis, secret reports","Commonly Shared Internal Information (e.g., corporate policies/standards, guidelines, operating procedures, interoffice memos)","Credit Card Information (e.g., PAN, track data, EMV chip data)","External & Regulatory reporting","Financial forecast or results, prior to general or public disclosure","Financial Information Related to Revenue Generation (e.g., balance sheet, profit & loss figures)","Internal Phone Directory","Interviews with news media","Legal Contract Information","Marketing Brochure","Mergers, acquisitions, or divestitures, prior to general or public disclosure","Press Releases","Product Offerings (future), Product formulas methodology or calculations","Published Annual Report, including financials","Securities issuer information that is non-public and material","Strategic plans on mergers, acquisitions, or divestitures, prior to general or public disclosure","Trade Secrets","Trading Books","Transaction Information","Vendor/Third Party Information"]
  APPLICABLE_TECHNICAL_SPECIALTY_DATA_TYPE = ["Audit/System/Security Logs","Internal Bank IP Address, MAC Address, Hostname and Domain","Metadata","Patents, trademarks, copyrights","Private and symmetric cryptographic key and key parts","Proprietary processes, algorithms or systems","Public cryptographic key","Source Code","Sytem Documentation (e.g., design, functional specs, process, procedure, configuration data, etc.)","Documentation (e.g., design, functional specs, process, producedure, configuration, data, etc.)"]
  

  def waiting_for_internal_lawyers_approval?
    self.lxp_id.present? && self.internal_lawyers_id.present? &&  self.lxp_status.nil?
  end
  
  def fully_approved?
    self.lxp_status === 'APPROVED' && self.docusign_retainer_envelope.try(:status) === 'completed'
  end

  def lxp_status_show
    if !self.lxp_status.blank?
      ExceptionRequest::EXCEPTION_REQUEST_STATUS2[self.lxp_status.try(:to_sym)]
    end
  end
  def internal_lawyers_status_show
    if self.internal_lawyers_status.present?
      ExceptionRequest::EXCEPTION_REQUEST_STATUS2[self.internal_lawyers_status.to_sym]
    end
  end

  def matter_types
    JSON.parse(self.read_attribute(:matter_types) || '{}').reject(&:blank?)
  end

  def pay_type_show
    if self.pay_type.present?
      ExceptionRequest::EXCEPTION_REQUEST_PAY_TYPE[self.pay_type.to_sym]
    end
  end

  def send_retainer_for_esigning(signer_email, signer_name)
    args = {
      envelope_args: {
        template_id: Rails.application.secrets[:docusign]["retainer_template_id"],
        signer_email: signer_email,
        signer_name: signer_name,
        lxp_email: SystemSetting.fetch.lxp_email,
        lxp_name: SystemSetting.fetch.lxp_name
      },
      base_path: Rails.application.secrets[:docusign]["base_path"],
      account_id: Rails.application.secrets[:docusign]["account_id"],
      access_token: SystemSetting.fetch.docusign_access_token,
      refresh_token: SystemSetting.fetch.docusign_refresh_token
    }

    begin
      envelope_args = args[:envelope_args]
      # 1. Create the envelope request object
      envelope_definition = make_envelope(envelope_args)
      # 2. call Envelopes::create API method
      # Exceptions will be caught by the calling function
      configuration = DocuSign_eSign::Configuration.new
      configuration.host = args[:base_path]
      api_client = DocuSign_eSign::ApiClient.new configuration
      api_client.default_headers["Authorization"] = "Bearer #{args[:access_token]}"
      envelope_api = DocuSign_eSign::EnvelopesApi.new(api_client)
      results = envelope_api.create_envelope args[:account_id], envelope_definition
      envelope_id = results.envelope_id
      
      self.docusign_envelope_id = envelope_id
      self.save

      ExceptionRequestMailer.form_status_notification_to_lob_for_sign(self).deliver_now
    rescue DocuSign_eSign::ApiError => e
      error = JSON.parse e.response_body
      puts "##### Docusign Error #####"
      @error_code = error['errorCode']
      @error_message = error['message']
      puts "Error code: #{@error_code} & Error msg: #{@error_message}"
    end
  end

  def docusign_retainer_envelope
    begin
      configuration = DocuSign_eSign::Configuration.new
      configuration.host = Rails.application.secrets[:docusign]["base_path"]
      api_client = DocuSign_eSign::ApiClient.new configuration
      api_client.default_headers["Authorization"] = "Bearer #{SystemSetting.fetch.docusign_access_token}"
      envelopesApi = DocuSign_eSign::EnvelopesApi.new api_client
      envelopesApi.get_envelope Rails.application.secrets[:docusign]["account_id"], self.docusign_envelope_id
    rescue Exception => e
      puts e
      nil
    end
  end

  def get_document_name
    configuration = DocuSign_eSign::Configuration.new
    configuration.host = Rails.application.secrets[:docusign]["base_path"]
    api_client = DocuSign_eSign::ApiClient.new configuration
    api_client.default_headers["Authorization"] = "Bearer #{SystemSetting.fetch.docusign_access_token}"
    envelopesApi = DocuSign_eSign::EnvelopesApi.new api_client
    doc_item = envelopesApi.list_documents Rails.application.secrets[:docusign]["account_id"], self.docusign_envelope_id

    doc_item = doc_item.envelope_documents[0]
    document_id = doc_item.name
  end
  def get_document_list
    begin
      configuration = DocuSign_eSign::Configuration.new
      configuration.host = Rails.application.secrets[:docusign]["base_path"]
      api_client = DocuSign_eSign::ApiClient.new configuration
      api_client.default_headers["Authorization"] = "Bearer #{SystemSetting.fetch.docusign_access_token}"
      envelopesApi = DocuSign_eSign::EnvelopesApi.new api_client
      doc_item = envelopesApi.list_documents Rails.application.secrets[:docusign]["account_id"], self.docusign_envelope_id

      doc_item = doc_item.envelope_documents[0]
      document_id = doc_item.document_id
      
      temp_file = envelopesApi.get_document Rails.application.secrets[:docusign]["account_id"], document_id, self.docusign_envelope_id
      # find the matching document information item
      # doc_item = doc_item.find { |item| item['document_id'] == document_id }

      doc_name = doc_item.name
      has_pdf_suffix = doc_name.upcase.end_with? '.PDF'
      pdf_file = has_pdf_suffix

      # Add ".pdf" if it's a content or summary doc and doesn't already end in .pdf
      if doc_item.type == "content" || (doc_item.type == "summary" && !has_pdf_suffix)
          doc_name += ".pdf"
          pdf_file = true
      end
      # Add .zip as appropriate
      if doc_item.type == "zip"
          doc_name += ".zip"
      end
      # Return the file information
      if pdf_file
        mime_type = 'application/pdf'
      elsif doc_item.type == 'zip'
        mime_type = 'application/zip'
      else
        mime_type = 'application/octet-stream'
      end

      #{'mime_type' => mime_type, 'doc_name' => doc_name, 'data' => }
      File.binread(temp_file.path)

      
    rescue Exception => e
      puts e
      nil
    end
  end


  
  def make_envelope(args)
    # create the envelope definition with the template_id
    envelope_definition = DocuSign_eSign::EnvelopeDefinition.new({
          :status => 'sent',
          :templateId => args[:template_id]
    })
    # Create the template role elements to connect the signer and lxp recipients
    # to the template
    signer = DocuSign_eSign::TemplateRole.new({
            :email => args[:signer_email],
            :name => args[:signer_name],
            :roleName => 'signer'
    })
    # Create a lxp template role.
    lxp = DocuSign_eSign::TemplateRole.new({
            :email => args[:lxp_email],
            :name => args[:lxp_name],
            :roleName => 'lxp'
    })

    text = DocuSign_eSign::Text.new
    text.document_id = '1'
    text.page_number = '1'
    text.x_position = '280'
    text.y_position = '172'
    text.font = 'helvetica'
    text.font_size = 'size14'
    text.tab_label = '*lawfirmname'
    text.height = '23'
    text.width = '84'
    text.required = 'false'
    text.locked = 'true'
    text.bold = 'true'
    text.value = self&.law_firm&.name
    text.locked = 'false'
    text.tab_id = 'name'

    tabs = DocuSign_eSign::Tabs.new
    tabs.text_tabs = [text]
    lxp.tabs = tabs

    # Add the TemplateRole objects to the envelope object
    envelope_definition.template_roles = [signer, lxp]
    envelope_definition
  end

  def matter_types_formated
    if self.matter_types_search.present?
      MatterType.find(self.matter_types_search).matter_type 
    end
  end

  def sub_matter_types_formated
    if self.sub_matter_types_search.present?
      SubMatterType.find(self.sub_matter_types_search).sub_matter_type 
    end
  end

  def jurisdiction_types_formated
    if self.jurisdiction_types_search.present?
      JurisdictionType.find(self.jurisdiction_types_search).jurisdiction_type 
    end
  end

  def countries_formated
    if self.countries_search.present?
      Country.find(self.countries_search).name 
    end
  end

  def states_formated
    if self.states_search.present?
      State.find(self.states_search).name 
    end
  end

  def show_countries_names
    name = []
    if self.law_firm && self.law_firm.countries && self.law_firm.countries.count > 0
      countries_ids = self.law_firm.countries.pluck(:country_id)
      if countries_ids.count > 0
        countries_ids.each do |country_id|
          country = Country.find_by(id: country_id)
          if country.present?
            name << country.name
          end
        end
      end
    end
    name&.join(", ")
  end

  def show_states_names
    name = []
    if self.law_firm && self.law_firm.states && self.law_firm.states.count > 0
      state_ids = self.law_firm.states.pluck(:state_id)
      if state_ids.count > 0
        state_ids.each do |state_id|
          state = State.find_by(id: state_id)
          if state.present?
            name << state.name
          end
        end
      end
    end
    name&.join(", ")
  end

  def show_matter_types
    if self.matter_types.nil?
      return ""
    else
      if self.matter_types.is_a? Array
        self.matter_types.compact.join(', ')
      elsif self.matter_types.is_a? Hash
        if self.matter_types.empty?
          return ""
        else 
          self.matter_types.to_s
        end
      else
        self.matter_types
      end
    end
  end

end
