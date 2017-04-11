class AddPlatformCategoryToTechnology < ActiveRecord::Migration[5.0]
  def change
    add_column :technologies, :platform_category, :string
    add_column :technologies, :platform_type, :string
  end
end
