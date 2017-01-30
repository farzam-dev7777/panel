class CreateFormValues < ActiveRecord::Migration[5.0]
  def change
    create_table :form_values do |t|
      t.integer :form_field_id
      t.integer :submittable_id
      t.string :value
      t.timestamps
    end
  end
end
