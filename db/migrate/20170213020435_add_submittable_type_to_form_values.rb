class AddSubmittableTypeToFormValues < ActiveRecord::Migration[5.0]
  def change
    add_column :form_values, :submittable_type, :string
  end
end
