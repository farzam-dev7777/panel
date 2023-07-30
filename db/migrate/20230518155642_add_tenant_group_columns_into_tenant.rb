class AddTenantGroupColumnsIntoTenant < ActiveRecord::Migration[5.0]
  def change
    add_column :tenants, :internal_lawyer, :string
    add_column :tenants, :master_user , :string
    add_column :tenants, :business_user, :string
  end
end
