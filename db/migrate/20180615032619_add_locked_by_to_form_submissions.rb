class AddLockedByToFormSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :form_submissions, :locked_by_id, :integer
    add_column :form_submissions, :locked_at, :datetime
  end
end
