class CreateValue < ActiveRecord::Migration[5.0]
  def change
    create_table :values , :id => false do |t|
      t.integer :law_firm_id
      t.integer :values_id
      t.string :value
      t.timestamps
    end
  end
end
