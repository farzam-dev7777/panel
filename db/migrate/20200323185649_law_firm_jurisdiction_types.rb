class LawFirmJurisdictionTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :law_firms_jurisdiction_types, :id => false do |t|
      t.integer :law_firm_id
      t.integer :jurisdiction_type_id
      t.timestamps
    end
  end
end
