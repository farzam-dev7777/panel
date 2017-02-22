class AddFormIdToFormSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :form_submissions, :form_id, :integer
  end
end
