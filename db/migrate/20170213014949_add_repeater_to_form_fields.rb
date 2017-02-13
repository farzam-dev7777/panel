class AddRepeaterToFormFields < ActiveRecord::Migration[5.0]
  def change
    add_column :form_fields, :repeater, :boolean
  end
end
