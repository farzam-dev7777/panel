class AddColFormConflictsIdToFormSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :form_submissions, :form_conflicts_id, :integer
  end
end
