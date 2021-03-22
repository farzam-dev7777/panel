class AddPanelAllowToSystemSettings < ActiveRecord::Migration[5.0]
  def up
    add_column :system_settings, :panel_status, :string, default: "No"
  end

  def down
    remove_column :system_settings, :panel_status
  end
end
