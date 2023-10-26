class CreateLawFirmAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :law_firm_attachments do |t|
      t.integer :law_firm_id
      t.integer :tenant_id
      t.string :file
      t.timestamps
    end
  end
end
