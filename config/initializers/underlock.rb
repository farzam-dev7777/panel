Underlock::Base.configure do |config|
  config.public_key  = File.read('config/keys/key.pub')
  config.private_key = File.read('tmp/key.priv')
  config.cipher      = OpenSSL::Cipher.new('aes-256-gcm')
end
