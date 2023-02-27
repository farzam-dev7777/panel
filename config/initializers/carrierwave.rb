if Rails.env.production? || Rails.env.external?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider:               'AWS',
      aws_access_key_id:      Rails.application.secrets[:s3]["access_key"],
      aws_secret_access_key:  Rails.application.secrets.s3['secret_key'],
      region:                 Rails.application.secrets.s3['region'],
    }

    config.fog_directory    = Rails.application.secrets.s3['bucket_name']
    config.fog_public       = false
  end
elsif Rails.env.staging? || Rails.env.internal? || Rails.env.development?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider:               'AWS',
      aws_access_key_id:      Rails.application.secrets[:s3]["access_key"],
      aws_secret_access_key:  Rails.application.secrets.s3['secret_key'],
      region:                 Rails.application.secrets.s3['region'],
    }

    config.fog_directory    = Rails.application.secrets.s3['bucket_name']
    config.fog_public       = false
  end
else
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end