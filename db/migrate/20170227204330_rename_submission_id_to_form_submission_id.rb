class RenameSubmissionIdToFormSubmissionId < ActiveRecord::Migration[5.0]
  def change
  	rename_column :technology_values, :submission_id, :form_submission_id
  end
end
