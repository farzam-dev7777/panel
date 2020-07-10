class ExceptionRequest < ApplicationRecord

  #serialize :matter_types, Array

  self.per_page = 10
  belongs_to :user
  belongs_to :law_firm
  has_many :activity_logs
  has_many :reviews, as: :reviewable
  serialize :reason, Array

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
    "Lending and Financing (inc. secured transactions and workouts) / Financement de prê",
    "transactions garanties et les redressements)",
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
  EXCEPTION_REQUEST_PAYER =  ["Bank Pay", "Customer Pay"]
  INVOLVED_ENGAGEMENT = [
    "Merger & Acquisition",
    "Litigation",
    "Personam Identifiable information > 10,000 records",
    "Combination of confidential information with over 10,000 records",
    "None of the above"
  ]
  #validates_presence_of :requested_by, :submitted_by_email, :line_of_business, :lob_contact_name, :minority_owned, :women_owned, :matter_name

  belongs_to :law_firm

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
    "": "Select",
    "REQUEST_TO_LAWYER": "Request Lawyer Approval",
    "APPROVED": "Approved",
    "REJECTED": "Rejected"
    
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

  def waiting_for_internal_lawyers_approval?
    self.lxp_id.present? && self.internal_lawyers_id.present? &&  self.lxp_status.nil?
  end
  
  def fully_approved?
    self.lxp_status === 'APPROVED' && self.docusign_retainer_envelope.try(:status) === 'completed'
  end

  def lxp_status_show
    if !self.lxp_status.blank?
      ExceptionRequest::EXCEPTION_REQUEST_STATUS[self.lxp_status.try(:to_sym)]
    end
  end
  def internal_lawyers_status_show
    if self.internal_lawyers_status.present?
      ExceptionRequest::EXCEPTION_REQUEST_STATUS[self.internal_lawyers_status.to_sym]
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
        signer_email: 'manpreet+lob@metawarelabs.com',
        signer_name: "Manish - LOB",
        lxp_email: Rails.application.secrets[:lxp_contact]["email"],
        lxp_name: Rails.application.secrets[:lxp_contact]["name"]
      },
      base_path: Rails.application.secrets[:docusign]["base_path"],
      account_id: Rails.application.secrets[:docusign]["account_id"],
      access_token: SystemSetting.fetch.docusign_access_token
    }

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

end
