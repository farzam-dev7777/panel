class CreateFileAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :file_attachments do |t|
      t.string :file
      t.integer :form_value_id

      t.timestamps
    end
  end
end
