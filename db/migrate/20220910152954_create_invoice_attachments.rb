class CreateInvoiceAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :invoice_attachments do |t|
      t.integer :invoice_id
      t.string :file
      t.text :iv
      t.text :key
      t.string :file_content_type
      t.string :file_size
      t.string :human_file_size

      t.timestamps
    end
  end
end
