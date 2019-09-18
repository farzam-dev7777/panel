class AddFormIdsToFormSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :form_submissions, :form_relationship_id, :integer
    add_column :form_submissions, :form_diversity_id, :integer
    add_column :form_submissions, :form_innovation_id, :integer
    add_column :form_submissions, :form_resourcing_id, :integer
  end
end
