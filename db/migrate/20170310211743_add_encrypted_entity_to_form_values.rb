class AddEncryptedEntityToFormValues < ActiveRecord::Migration[5.0]
  def change
    add_column :form_values, :form_value_iv, :string
    add_column :form_values, :form_value_key, :string
  end
end
