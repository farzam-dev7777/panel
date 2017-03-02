class AddSubmittedToFormSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :form_submissions, :submitted, :boolean, default: false
  end
end
