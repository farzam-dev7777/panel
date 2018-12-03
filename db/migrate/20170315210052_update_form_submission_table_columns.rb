class UpdateFormSubmissionTableColumns < ActiveRecord::Migration[5.0]
  def change
  	add_column 		:form_submissions, :assessor_score, :float
  	add_column 		:form_submissions, :system_score, :float
  	change_column :form_submissions, :score, :float
  	rename_column :form_submissions, :score, :total_score
  end
end
