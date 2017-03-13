class CreateQueuedNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :queued_notifications do |t|
      t.datetime 	:trigger_at
      t.integer 	:trigger_id
      t.integer 	:action_item_id
      t.boolean 	:triggered, default: false
      t.datetime 	:deleted_at

      t.timestamps
    end
    add_index :queued_notifications, :deleted_at
  end
end
