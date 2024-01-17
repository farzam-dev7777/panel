class CreateRfps < ActiveRecord::Migration[7.0]
  def change
    create_table :rfps do |t|
      t.integer :matter_intake_id
      t.integer :user_id
      t.datetime :expiry_date
      t.string :status
      t.timestamps
    end
  end
end
