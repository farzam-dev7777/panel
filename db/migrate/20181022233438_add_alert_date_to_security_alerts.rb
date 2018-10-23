class AddAlertDateToSecurityAlerts < ActiveRecord::Migration[5.0]
  def change
    add_column :security_alerts, :alert_date, :datetime
  end
end
