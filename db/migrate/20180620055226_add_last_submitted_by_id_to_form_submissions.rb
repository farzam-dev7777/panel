class AddLastSubmittedByIdToFormSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :form_submissions, :last_submitted_by_id, :integer
  end
end
