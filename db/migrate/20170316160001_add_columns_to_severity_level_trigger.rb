class AddColumnsToSeverityLevelTrigger < ActiveRecord::Migration[5.0]
  def change
  	add_column :security_threats, :severity_negative_factor, :float
  	add_column :queued_notifications, :severity_negative_factor, :float
  end
end
