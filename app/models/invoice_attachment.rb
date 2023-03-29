class InvoiceAttachment < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  belongs_to :invoice

  mount_uploader :file, FileUploader

  attr_accessor :encrypted

  # before_create :encrypt

  before_save :update_attachment_attributes

  # before_destroy :remove_physical_file

  after_save :save_veryfi

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

  def save_veryfi
    veryfi_client = Veryfi::Client.new(
      client_id: Rails.application.secrets['veryfi']['client_id'],
      client_secret: Rails.application.secrets['veryfi']['client_secret'],
      username: Rails.application.secrets['veryfi']['username'],
      api_key: Rails.application.secrets['veryfi']['api_key']
    )
    ## write to temp file
    tempfile = Tempfile.new("veryfi-#{self.id}")
    tempfile.binmode
    tempfile.write(self.file.file.read)
    tempfile.close
    params = {
      file_path: tempfile.path,
      auto_delete: true,
      boost_mode: false,
      async: false,
      external_id: self.id,
      max_pages_to_process: 10
    }
    response = veryfi_client.document.process(params) rescue {}
    if response.present?
      self.update_columns(veryfi_response: response)
      if response['total'].present? && response['currency_code'].present?
        self.invoice.update_columns(amount_currency: response['currency_code'], amount_cents: response['total'])
      end
    end
    tempfile.delete
  end

  private

  def update_attachment_attributes
    if file.present? && file_changed?
      self.file_content_type = file.file.content_type
      self.file_size = file.file.size
      self.human_file_size = number_to_human_size(file.file.size)
    end
  end

end
