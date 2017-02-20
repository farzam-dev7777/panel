class AddFieldLogicToFormFields < ActiveRecord::Migration[5.0]
  def change
    add_column :form_fields, :custom_logic, :boolean
    add_column :form_fields, :show_when_form_field_id, :integer
    add_column :form_fields, :show_when_form_field_value, :string
  end
end
