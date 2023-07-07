Recaptcha.configure do |config|
  config.site_key  = Rails.application.secrets['RECAPTCHA_SITE_KEY_V3']
  config.secret_key = Rails.application.secrets['RECAPTCHA_SITE_SECRET_KEY_V3']
end