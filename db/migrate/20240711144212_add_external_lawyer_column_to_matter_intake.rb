class AddExternalLawyerColumnToMatterIntake < ActiveRecord::Migration[7.0]
  def change
    add_column :matter_intakes, :assign_lawyer, :string
  end
end
