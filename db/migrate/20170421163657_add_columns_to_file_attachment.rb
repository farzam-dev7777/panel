class AddColumnsToFileAttachment < ActiveRecord::Migration[5.0]
  def change
    add_column :file_attachments, :attachable_type, :string
    add_column :file_attachments, :attachable_id, :integer
  end
end
