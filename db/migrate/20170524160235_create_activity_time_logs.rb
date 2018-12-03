class CreateActivityTimeLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :activity_time_logs do |t|
      t.date :network_discovery
      t.date :penetration_testing
      t.date :vulnerability_assessment
      t.date :hardware_refresh
      t.date :hardware_inventory
      t.date :software_inventory
      t.integer :form_value_id

      t.timestamps
    end
  end
end
