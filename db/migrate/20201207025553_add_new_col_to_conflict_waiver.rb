class AddNewColToConflictWaiver < ActiveRecord::Migration[5.0]
  def change
    add_column :conflict_waivers, :repesenting, :string
    add_column :conflict_waivers, :name_of_other_client, :text
    add_column :conflict_waivers, :description_of_transaction, :text
    add_column :conflict_waivers, :nature_of_mandate, :text
    add_column :conflict_waivers, :office_locattion, :text
    add_column :conflict_waivers, :names_of_primary, :text
    add_column :conflict_waivers, :types_of_matters, :text
  end
end
