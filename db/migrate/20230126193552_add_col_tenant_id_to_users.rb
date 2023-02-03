class AddColTenantIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :tenant_id, :string
  end
end
