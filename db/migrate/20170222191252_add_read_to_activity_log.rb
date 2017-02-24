class AddReadToActivityLog < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_logs, :read, :boolean
  end
end
