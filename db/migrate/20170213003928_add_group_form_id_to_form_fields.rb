class AddGroupFormIdToFormFields < ActiveRecord::Migration[5.0]
  def change
    add_column :form_fields, :group_form_id, :integer
  end
end
