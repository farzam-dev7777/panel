class AddColWorkAreaTypeToMatterIntakes < ActiveRecord::Migration[5.0]
  def change
    add_column :matter_intakes, :work_area_type, :string
  end
end
