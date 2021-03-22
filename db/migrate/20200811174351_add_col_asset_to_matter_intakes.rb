class AddColAssetToMatterIntakes < ActiveRecord::Migration[5.0]
  def change
    add_column :matter_intakes, :asset, :string
  end
end
