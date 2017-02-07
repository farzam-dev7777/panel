class AddParentIdToFormFields < ActiveRecord::Migration[5.0]
  def change
    add_column :form_fields, :parent_id, :integer
  end
end
