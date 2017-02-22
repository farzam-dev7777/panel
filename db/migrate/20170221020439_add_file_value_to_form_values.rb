class AddFileValueToFormValues < ActiveRecord::Migration[5.0]
  def change
    add_column :form_values, :file_value, :string
  end
end
