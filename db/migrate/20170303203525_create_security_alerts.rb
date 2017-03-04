class CreateSecurityAlerts < ActiveRecord::Migration[5.0]
  def change
    create_table :security_alerts do |t|
      t.string :title
      t.text :description
      t.string :severity
      t.string :link

      t.timestamps
    end
  end
end
