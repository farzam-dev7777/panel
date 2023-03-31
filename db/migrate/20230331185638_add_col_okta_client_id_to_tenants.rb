class AddColOktaClientIdToTenants < ActiveRecord::Migration[5.0]
  def change
    add_column :tenants, :okta_client_id, :string
    add_column :tenants, :okta_client_secret, :string
    add_column :tenants, :okta_site, :string
    add_column :tenants, :okta_api_token, :string
  end
end
