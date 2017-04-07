class AddRelationshipManagerEmailToLawFirm < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :relationship_manager_email, :string
    add_column :form_submissions, :expiry_date, :date
  end
end
