class RenameColUidToUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :uid, :provider_uid
    rename_column :users, :okta_group, :provider_group
  end
end
