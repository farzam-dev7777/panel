class AddFormableIdToFormFields < ActiveRecord::Migration[5.0]
  def change
    add_column :form_fields, :formable_id, :integer
    add_column :form_fields, :formable_type, :string
  end
end
