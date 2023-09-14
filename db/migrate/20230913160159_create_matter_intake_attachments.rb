class CreateMatterIntakeAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :matter_intake_attachments do |t|
      t.integer :matter_intake_id
      t.string :doc_type
      t.string :file

      t.timestamps
    end
  end
end
