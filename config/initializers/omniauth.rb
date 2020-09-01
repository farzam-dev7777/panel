# frozen_string_literal: true

#require 'docusign'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :docusign, Rails.application.secrets[:docusign]["integration_key"], Rails.application.secrets[:docusign]["integration_secret"], sandbox: true,
           setup: lambda { |env|
             strategy = env['omniauth.strategy']
             strategy.options[:client_options].site = Rails.application.secrets[:docusign]["app_url"]
             strategy.options[:prompt] = 'login'
             strategy.options[:oauth_base_uri] = Rails.application.secrets[:docusign]["authorization_server"]
             strategy.options[:target_account_id] = Rails.application.secrets[:docusign]["target_account_id"]
             strategy.options[:allow_silent_authentication] = Rails.application.secrets[:docusign]["allow_silent_authentication"]
           }
end
