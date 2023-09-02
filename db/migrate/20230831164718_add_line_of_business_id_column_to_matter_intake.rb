class AddLineOfBusinessIdColumnToMatterIntake < ActiveRecord::Migration[5.0]
  def change
    add_column :matter_intakes, :line_of_business_id, :integer
  end
end
