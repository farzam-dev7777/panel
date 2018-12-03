class AddNeverColumnsToActivityTimeLog < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_time_logs, :network_discovery_never, :boolean, default: false
    add_column :activity_time_logs, :penetration_testing_never, :boolean, default: false
    add_column :activity_time_logs, :vulnerability_assessment_never, :boolean, default: false
    add_column :activity_time_logs, :hardware_refresh_never, :boolean, default: false
    add_column :activity_time_logs, :hardware_inventory_never, :boolean, default: false
    add_column :activity_time_logs, :software_inventory_never, :boolean, default: false
  end
end
