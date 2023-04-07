class ChangeColTypeTenantIdStringToIntegerInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :tenant_id, 'integer USING CAST(tenant_id AS integer)'
  end
end
