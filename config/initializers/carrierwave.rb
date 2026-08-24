if Rails.env.production? || Rails.env.external?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider:                        'AWS',
      aws_access_key_id:               ENV['DO_ACCESS_KEY'],
      aws_secret_access_key:           ENV['DO_SECRET_KEY'],
      region:                          ENV['DO_REGION'],
      endpoint:                        ENV['DO_ENDPOINT'] || "https://#{ENV['DO_REGION']}.digitaloceanspaces.com",
      enable_signature_v4_streaming:   false
    }

    config.fog_directory    = ENV['DO_BUCKET_NAME']
    config.fog_public       = false
  end
elsif Rails.env.staging? || Rails.env.internal? || Rails.env.development?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider:                        'AWS',
      aws_access_key_id:               ENV['DO_ACCESS_KEY'],
      aws_secret_access_key:           ENV['DO_SECRET_KEY'],
      region:                          ENV['DO_REGION'],
      endpoint:                        ENV['DO_ENDPOINT'] || "https://#{ENV['DO_REGION']}.digitaloceanspaces.com",
      enable_signature_v4_streaming:   false
    }

    config.fog_directory    = ENV['DO_BUCKET_NAME']
    config.fog_public       = false
  end
else
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end