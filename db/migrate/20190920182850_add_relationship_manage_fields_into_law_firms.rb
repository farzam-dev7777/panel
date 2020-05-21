class AddRelationshipManageFieldsIntoLawFirms < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :relationship_manager_name, :string
    add_column :law_firms, :relationship_manager_phone, :string
  end
end
