class AddOptionsToFormFields < ActiveRecord::Migration[5.0]
  def up
    add_column :form_fields, :options, :text, array: true, default: []
    add_index :form_fields, :options, using: 'gin'
  end

  def down
    remove_column :form_fields, :options
    remove_index :form_fields, :options
  end
end
