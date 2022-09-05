class RemoveColDefultValueLxpEmailToSystemSettings < ActiveRecord::Migration[5.0]
  def change
    change_column_default :system_settings, :lxp_name, from: "Manpreet", to: ""
    change_column_default :system_settings, :lxp_email, from: "manpreet@metawarelabs.com", to: ""
  end
end
