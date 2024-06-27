class AddRfpEnableColumnToTenants < ActiveRecord::Migration[7.0]
  def change
    add_column :tenants, :rfp_enable, :boolean
  end
end
