class AddNotifyToActivityLog < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_logs, :notify, :boolean
  end
end
