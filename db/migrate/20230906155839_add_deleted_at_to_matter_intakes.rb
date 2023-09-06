class AddDeletedAtToMatterIntakes < ActiveRecord::Migration[5.0]
  def change
    add_column :matter_intakes, :deleted_at, :datetime
  end
end
