class AddColSsoTypeToTenants < ActiveRecord::Migration[5.0]
  def change
    add_column :tenants, :sso_type, :string
    add_column :tenants, :azure_client_id, :string
    add_column :tenants, :azure_client_secret, :string
    add_column :tenants, :azure_tenant_id, :string
  end
end
