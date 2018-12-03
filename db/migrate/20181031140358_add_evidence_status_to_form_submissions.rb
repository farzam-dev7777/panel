class AddEvidenceStatusToFormSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :form_submissions, :evidence_status, :string
  end
end
