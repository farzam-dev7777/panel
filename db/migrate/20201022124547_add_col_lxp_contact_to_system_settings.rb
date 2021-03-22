class AddColLxpContactToSystemSettings < ActiveRecord::Migration[5.0]
  def up  
    add_column :system_settings, :lxp_name, :string, default: "Manpreet"
    add_column :system_settings, :lxp_email, :string, default: "manpreet@grcconsulting.ca"
  end

  def down
  remove_column :system_settings, :lxp_name
  remove_column :system_settings, :lxp_email
  end
end