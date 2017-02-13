class AddFormFieldLabelToFormValues < ActiveRecord::Migration[5.0]
  def change
    add_column :form_values, :form_field_label, :string
  end
end
