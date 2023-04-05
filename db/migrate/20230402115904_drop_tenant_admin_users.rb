class DropTenantAdminUsers < ActiveRecord::Migration[5.0]
  def change
    drop_table :tenant_admin_users
  end
end
