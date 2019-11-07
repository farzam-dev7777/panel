class AddLawFirmCategoryFieldIntoLawFirms < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :law_firm_category, :string
  end
end
