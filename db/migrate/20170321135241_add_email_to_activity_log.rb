class AddEmailToActivityLog < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_logs, :email, :string
    add_column :activity_logs, :source, :string
  end
end
