class AddHelpDescriptionToFormField < ActiveRecord::Migration[5.0]
  def change
    add_column :form_fields, :help_description, :text
  end
end
