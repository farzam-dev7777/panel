class AddEncryptionKeysToFileAttachment < ActiveRecord::Migration[5.0]
  def change
    add_column :file_attachments, :iv, :text
    add_column :file_attachments, :key, :text
  end
end
