class CreateThirdPartyVendors < ActiveRecord::Migration[5.0]
  def change
    create_table :third_party_vendors do |t|
      t.integer :form_value_id
      t.string :vendor_name
      t.string :area
      t.string :confidentiality_agreement

      t.timestamps
    end
  end
end
