class CreateProposals < ActiveRecord::Migration[7.0]
  def change
    create_table :proposals do |t|
      t.integer :rfp_id
      t.integer :user_id
      t.integer :law_firm_id
      t.float :amount
      t.text :description
      t.string :status
      t.timestamps
    end
  end
end
