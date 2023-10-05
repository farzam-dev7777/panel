class AddLawFirmHandleIntoLawFirmTenant < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms_tenants, :type_of_matters_your_law_firm_handles_for_us, :text
    remove_column :law_firms, :type_of_matters_your_law_firm_handles_for_us
  end
end
