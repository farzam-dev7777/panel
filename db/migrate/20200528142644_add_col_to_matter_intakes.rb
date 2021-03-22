class AddColToMatterIntakes < ActiveRecord::Migration[5.0]
  def change
    add_column :matter_intakes, :following_matter_involve, :string
    add_column :matter_intakes, :deal_code, :string
  end
end