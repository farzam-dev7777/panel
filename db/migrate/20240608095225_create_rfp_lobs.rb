class CreateRfpLobs < ActiveRecord::Migration[7.0]
  def change
    create_table :rfp_lobs do |t|
      t.integer :user_id
      t.integer :rfp_id
      t.string :role
      t.boolean :notify
      t.timestamps
    end
  end
end
