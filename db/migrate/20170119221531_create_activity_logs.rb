class CreateActivityLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :activity_logs do |t|
      t.integer :law_firm_id
      t.string :event_type
      t.string :custom_message
      t.string :loggable_type
      t.integer :loggable_id

      t.timestamps
    end
    add_index :activity_logs, [:loggable_type, :loggable_id]
  end
end
