class LawFirmState < ActiveRecord::Migration[5.0]
  def change
    create_table :law_firms_states do |t|
      t.integer :law_firm_id
      t.integer :state_id
      t.timestamps
    end
  end
end
