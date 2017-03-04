class AddStatusToFormSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :form_submissions, :status, :string
  end
end
