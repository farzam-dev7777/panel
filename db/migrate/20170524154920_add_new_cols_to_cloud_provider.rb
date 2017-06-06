class AddNewColsToCloudProvider < ActiveRecord::Migration[5.0]
  def change
    add_column :cloud_providers, :cloud_type, :string
    add_column :cloud_providers, :data, :string
    add_column :cloud_providers, :encrypted_in_flight, :string
    add_column :cloud_providers, :encrypted_at_rest, :string
  end
end
