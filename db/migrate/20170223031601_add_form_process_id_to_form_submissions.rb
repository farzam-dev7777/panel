class AddFormProcessIdToFormSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :form_submissions, :form_process_id, :integer
  end
end
