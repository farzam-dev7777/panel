class AddMultiSelectValueToFormValue < ActiveRecord::Migration[5.0]
  def change
    add_column :form_values, :multi_select_value, :text
  end
end
