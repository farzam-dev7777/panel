class AddVeryfiResponseToInvoiceAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :invoice_attachments, :veryfi_response, :jsonb
  end
end
