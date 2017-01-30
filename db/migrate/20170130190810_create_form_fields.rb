class CreateFormFields < ActiveRecord::Migration[5.0]
  def change
    create_table :form_fields do |t|
      t.string :min
      t.string :max
      t.boolean :required
      t.string :label
      t.string :type
      t.timestamps
    end
  end
end
