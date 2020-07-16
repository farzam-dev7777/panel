class AddColContactNameToLawFirms < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :contact_name, :string
  end
end
