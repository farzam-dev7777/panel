class CreateCloudProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :cloud_providers do |t|
      t.integer :form_value_id
      t.string :name
      t.string :service
      t.string :data_store_location_ca

      t.timestamps
    end
  end
end
