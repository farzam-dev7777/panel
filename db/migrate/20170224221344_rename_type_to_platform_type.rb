class RenameTypeToPlatformType < ActiveRecord::Migration[5.0]
  def change
  	rename_column :technology_values, :type, :platform_type
  	add_column :technology_values, :technology_id, :integer
  end
end
