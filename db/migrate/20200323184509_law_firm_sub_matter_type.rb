class LawFirmSubMatterType < ActiveRecord::Migration[5.0]
  def change
    create_table :law_firms_sub_matter_types, :id => false do |t|
      t.integer :law_firm_id
      t.integer :sub_matter_type_id
      t.timestamps
    end
  end
end
