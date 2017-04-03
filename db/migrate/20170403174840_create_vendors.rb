class CreateVendors < ActiveRecord::Migration[5.0]
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :vendor_type
      t.string :application
      t.integer :form_value_id

      t.timestamps
    end
  end
end
