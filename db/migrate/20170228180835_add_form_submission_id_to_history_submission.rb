class AddFormSubmissionIdToHistorySubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :history_submissions, :form_submission_id, :integer
  end
end
