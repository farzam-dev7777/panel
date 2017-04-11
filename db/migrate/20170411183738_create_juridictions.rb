class CreateJuridictions < ActiveRecord::Migration[5.0]
  def change
    create_table :jurisdictions do |t|
      t.string :country
      t.string :city
      t.integer :law_firm_id

      t.timestamps
    end
  end
end
