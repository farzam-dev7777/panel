class AddExtraColumnToMaterIntakes < ActiveRecord::Migration[5.0]
  def change
    add_column :matter_intakes, :requested_by_id, :integer
    add_column :matter_intakes, :related_matter_number, :string
    add_column :matter_intakes, :pii_involved, :boolean
    add_column :matter_intakes, :internal_file_number, :string
    add_column :matter_intakes, :business_department, :string
    add_column :matter_intakes, :business_group, :string
    add_column :tenants, :matter_optional_fields, :string
  end
end
