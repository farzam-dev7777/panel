require 'tempfile'
class FileAttachment < ApplicationRecord
  attr_accessor :encrypted

  belongs_to :attachable, polymorphic: true
  belongs_to :form_value
  mount_uploader :file, FileUploader

  before_create :encrypt

  before_destroy :remove_physical_file

  def remove_physical_file
    self.file.remove!
  end

  def encrypt
    return if self.encrypted
    file = File.open(self.file.file.file)
    encrypted_entity = Underlock::Base.encrypt(file)
    self.key = encrypted_entity.key
    self.iv = encrypted_entity.iv
    self.encrypted = true
    File.write("#{self.file.file.file}", File.read(encrypted_entity.encrypted_file))
  end

  def decrypt(pkey)
    Underlock::Base.config[:private_key] = pkey
    encrypted_file = File.open(self.file.file.file)
    encrypted_entity = Underlock::EncryptedEntity.new(encrypted_file: encrypted_file, key: key, iv: iv)
    
    begin
      decrypted_file = Underlock::Base.decrypt(encrypted_entity)
    rescue
      Underlock::Base.config[:cipher] = OpenSSL::Cipher.new('aes-256-ofb')
      decrypted_file = Underlock::Base.decrypt(encrypted_entity)
    end
    
    temp_file = Tempfile.new(File.basename(encrypted_file))
    temp_file.write(decrypted_file.read)
    File.delete(decrypted_file)
    temp_file
  end
end
