class CreateLawFirmsCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :law_firms_countries do |t|
      t.integer :law_firm_id
      t.integer :country_id
      t.timestamps
    end
  end
end
