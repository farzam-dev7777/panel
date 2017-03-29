class CreateLogics < ActiveRecord::Migration[5.0]
  def change
    create_table :logics do |t|
      t.integer :listen_field_id
      t.integer :change_field_id
      t.integer :form_id
      t.string :logic_to_be_applied
      t.string :values
      t.string :perform_action

      t.timestamps
    end
  end
end
