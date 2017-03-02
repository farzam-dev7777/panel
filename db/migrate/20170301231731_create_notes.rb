class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.integer :law_firm_id
      t.string :type
      t.text :message
      t.string :step
      t.integer :admin_user_id
      t.string :sender

      t.timestamps
    end
  end
end
