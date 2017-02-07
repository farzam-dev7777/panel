class CreateDropdownOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :dropdown_options do |t|
      t.string  :key
      t.string  :value
      t.integer :form_field_id

      t.timestamps
    end
  end
end
