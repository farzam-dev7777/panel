class DocusignClient

  attr_accessor :api_client

  def initialize
    configuration = DocuSign_eSign::Configuration.new
    configuration.host = Rails.application.secrets[:docusign]["base_path"]
    self.api_client = DocuSign_eSign::ApiClient.new configuration
    self.api_client.default_headers["Authorization"] = "Bearer #{SystemSetting.fetch.docusign_access_token}"
  end

  def template_api
    DocuSign_eSign::TemplatesApi.new self.api_client
  end

  def envelope_api
    DocuSign_eSign::EnvelopesApi.new self.api_client
  end
end