class RenameTypeToMessageType < ActiveRecord::Migration[5.0]
  def change
  	rename_column :notes, :type, :message_type
  	rename_column :notes, :submission_id, :form_submission_id
  end
end
