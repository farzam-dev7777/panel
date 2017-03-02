class AddSubmittedOnToFormSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :form_submissions, :submitted_on, :datetime
  end
end
