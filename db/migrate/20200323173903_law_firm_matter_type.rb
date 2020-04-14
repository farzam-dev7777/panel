class LawFirmMatterType < ActiveRecord::Migration[5.0]
  def change
    create_table :law_firms_matter_types, :id => false do |t|
      t.integer :law_firm_id
      t.integer :matter_type_id
      t.timestamps
    end
  end
end
