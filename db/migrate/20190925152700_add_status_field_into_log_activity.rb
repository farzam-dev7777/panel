class AddStatusFieldIntoLogActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_logs, :status, :string
  end
end
