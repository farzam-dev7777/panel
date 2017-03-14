class AddReasonToFormSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :form_submissions, :reason, :string
  end
end
