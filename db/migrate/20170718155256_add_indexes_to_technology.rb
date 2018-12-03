class AddIndexesToTechnology < ActiveRecord::Migration[5.0]
  def change
  	add_index :technologies, :vendor
  	add_index :technologies, [:vendor, :platform]
  	add_index :technologies, [:platform, :version]
  	add_index :technologies, [:version, :service_pack]
  end
end
