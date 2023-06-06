class AddAllowToCreateMattersIntoLawFirm < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms_tenants, :allow_to_create_matters, :boolean
  end
end
