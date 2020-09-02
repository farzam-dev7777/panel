class AddColDocusignTokenExpiresAtToSystemSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :system_settings, :docusign_token_expires_at, :datetime
  end
end
