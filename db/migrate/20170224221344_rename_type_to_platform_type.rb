class RenameTypeToPlatformType < ActiveRecord::Migration[5.0]
  def change
  	rename_column :technologies, :type, :platform_type
  	add_column :technologies, :technology_id, :integer
  end
end
