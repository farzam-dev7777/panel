class AddColDocusignRefreshTokenToSystemSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :system_settings, :docusign_refresh_token, :text
  end
end
