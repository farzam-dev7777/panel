class AddColMatterNumberToMatterIntakes < ActiveRecord::Migration[5.0]
  def change
    add_column :matter_intakes, :matter_number, :string
    add_column :matter_intakes, :lxp_reviewed_at, :datetime
  end
end
