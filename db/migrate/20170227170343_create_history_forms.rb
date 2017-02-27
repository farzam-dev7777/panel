class CreateHistoryForms < ActiveRecord::Migration[5.0]
  def change
    create_table :history_forms do |t|
      t.string :incident_type
      t.string :impact
      t.string :discovery_time
      t.string :source
      t.string :data_loss
      t.text :incident_details

      t.timestamps
    end
  end
end
