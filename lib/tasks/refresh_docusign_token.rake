require 'uri'
require 'net/http'

namespace :docusign do
  desc "Refresh Token"
  task refresh_token: :environment do
    puts "#### Token refresh process begins ####"

    token = SystemSetting.fetch.docusign_access_token
    refresh_token = SystemSetting.fetch.docusign_refresh_token

    uri = URI("https://account-d.docusign.com/oauth/token")
    params = {
      "grant_type" => "refresh_token", 
      "refresh_token" => refresh_token
    }
    code = Base64.strict_encode64("#{Rails.application.secrets[:docusign]['integration_key']}:#{Rails.application.secrets[:docusign]['integration_secret']}")
    headers = {
      'Authorization'=>"Basic #{code}",
      'Content-Type' =>'application/json',
      'Accept'=>'application/json'
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    response = http.post(uri.path, params.to_json, headers)

    puts "### Response ####"
    puts response.inspect

    if response.code === "200"
      # update response in db
      result = JSON.parse(response.body)
      @settings = SystemSetting.fetch

      @settings.update_attributes(
        docusign_access_token: result['access_token'], 
        docusign_refresh_token: result['refresh_token'], 
        docusign_token_expires_at: Time.now + result['expires_in'].to_i.seconds
      )
      puts "#### Token updated ####"
    end
  end

end