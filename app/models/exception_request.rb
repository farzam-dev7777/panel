class ExceptionRequest < ApplicationRecord

  #serialize :matter_types, Array

  self.per_page = 10
  belongs_to :user

  LOB_LIST = ["Canadian P&C", "Capital Markets", "Corporate", "Technology & Operations", "US P&C", "Wealth Management"]
  REQUEST_TYPE = {
    "EXCEPTION": "Exception",
    "ADD_TO_LAW_FIRM_PANEL": "Add to Law Firm Panel"
  }
  LAW_FIRM_CATEGORIES = {
    "PANEL": "Panel",
    "NON_PANEL": "Non Panel"
  }

  MATTER_TYPES = ["MATTER_TYPE_1", "MATTER_TYPE_2", "MATTER_TYPE_3"]
  MINORITY_OWNED_TYPE = ["Yes", "No"]
  WOMEN_OWNED_TYPE = ["Yes", "No"]

  validates_presence_of :requested_by, :submitted_by_email, :line_of_business, :lob_contact_name, :law_firm_category, :minority_owned, :women_owned, :matter_name

  belongs_to :law_firm

  def send_retainer_for_esigning(signer_email, signer_name)
    args = {
      envelope_args: {
        template_id: Rails.application.secrets[:docusign]["retainer_template_id"],
        signer_email: signer_email,
        signer_name: signer_name,
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

end
