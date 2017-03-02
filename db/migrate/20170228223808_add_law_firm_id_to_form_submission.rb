class AddLawFirmIdToFormSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :form_submissions, :law_firm_id, :integer
  end
end
