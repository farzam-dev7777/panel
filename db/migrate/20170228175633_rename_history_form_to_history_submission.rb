class RenameHistoryFormToHistorySubmission < ActiveRecord::Migration[5.0]
  def change
  	rename_table :history_forms, :history_submissions
  end
end
