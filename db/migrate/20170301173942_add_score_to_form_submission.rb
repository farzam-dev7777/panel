class AddScoreToFormSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :form_submissions, :score, :float
  end
end
