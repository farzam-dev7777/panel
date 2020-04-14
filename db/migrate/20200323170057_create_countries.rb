class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.integer :country_id
      t.string :name
      t.string :iso
      t.timestamps
    end
  end
end
