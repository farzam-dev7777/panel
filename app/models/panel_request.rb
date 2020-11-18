class PanelRequest < ApplicationRecord

  #serialize :matter_types, Array

  self.per_page = 10
  belongs_to :user
  belongs_to :law_firm
  accepts_nested_attributes_for :law_firm
  has_many :activity_logs
  has_many :reviews, as: :reviewable


  LOB_LIST = ["Canadian P&C / Services bancaires Particuliers et entreprises - Canada","Capital Markets / Marché des capitaux","Corporate / Services d'entreprise","Technology & Operations / Technologie et opérations (T&O)","US P&C / Services bancaires Particuliers et entreprises - É.-U.","Wealth Management / Gestion de patrimonie"]
  REQUEST_TYPE = {
    "EXCEPTION": "Exception",
    "ADD_TO_LAW_FIRM_PANEL": "Add to Law Firm Panel"
  }
  LAW_FIRM_CATEGORIES = {
    "PANEL": "Panel",
    "NON_PANEL": "Non Panel"
  }
  PANAL_STATUS = ['Activate', 'Received']
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

 
  PANEL_REQUEST_STATUS = {
    "": "Select",
    "REQUEST_INFO": "Request More Info",
    "PANEL_RETAINER": "Retainer sent",
    "LAW_FIRM_CREATED": "Law Firm Created",
    "ARCHIVED": "Archived",
    "UN_ARCHIVED": "Un Archived",
    "APPROVED": "Approved",
    "REJECTED": "Rejected"
  }

  INVOLVED_ENGAGEMENT = [
    "Merger/Acquisition",
    "Litigation",
    "Personal Identifiable information > 10,000 records",
    "Combination of sensitive and confidential information with over 10,000 records",
    "Combination of confidential information with over 10,000 records",
    "None of the above"
  ]

  validates_presence_of :submitted_by_email, :line_of_business, :women_owned, :niche_preferred_external_counsel_panel_law_firms, :matter_types, :required_unique_geography, :involved_engagement, :women_owned, :law_frim_name, :law_firm_contact_name, :law_firm_mail, :law_firm_role, :law_firm_phone, :firm_use_on_regular_basis


  def matter_types
    JSON.parse(self.read_attribute(:matter_types) || '[]').reject(&:blank?)
  end

  def lxp_status_show
    if !self.lxp_status.blank?
      PanelRequest::PANEL_REQUEST_STATUS[self.lxp_status.try(:to_sym)]
    end
  end
  def fully_approved?
    self.lxp_status === 'APPROVED' && self.docusign_retainer_envelope.try(:status) === 'completed'
  end

  def send_retainer_for_esigning(lob_email, lob_name, user_email, user_name)
    args = {
      envelope_args: {
        template_id: Rails.application.secrets[:docusign]["retainer_template_id_panel"],
        signer_email: user_email,
        signer_name: user_name,
        lob_email: lob_email,
        lob_name: lob_name
      },
      base_path: Rails.application.secrets[:docusign]["base_path"],
      account_id: Rails.application.secrets[:docusign]["account_id"],
      access_token: SystemSetting.fetch.docusign_access_token
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
    rescue DocuSign_eSign::ApiError => e
      error = JSON.parse e.response_body
      puts "##### Docusign Error Panel #####"
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
            :email => args[:lob_email],
            :name => args[:lob_name],
            :roleName => 'lob'
    })

    # text = DocuSign_eSign::Text.new
    # text.document_id = '1'
    # text.page_number = '1'
    # text.x_position = '280'
    # text.y_position = '172'
    # text.font = 'helvetica'
    # text.font_size = 'size14'
    # text.tab_label = '*lawfirmname'
    # text.height = '23'
    # text.width = '84'
    # text.required = 'false'
    # text.locked = 'true'
    # text.bold = 'true'
    # text.value = self&.law_firm&.name
    # text.locked = 'false'
    # text.tab_id = 'name'

    # tabs = DocuSign_eSign::Tabs.new
    # tabs.text_tabs = [text]
    # lxp.tabs = tabs
    # signer.tabs = tabs
   
    # Add the TemplateRole objects to the envelope object
    envelope_definition.template_roles = [signer, lxp]
    envelope_definition
  end

end

