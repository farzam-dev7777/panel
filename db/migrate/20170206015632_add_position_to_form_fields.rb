class AddPositionToFormFields < ActiveRecord::Migration[5.0]
  def change
    add_column :form_fields, :position, :integer
    add_index :form_fields, [:position]
  end
end
