class AddGroupFormToForms < ActiveRecord::Migration[5.0]
  def change
    add_column :forms, :group_form, :boolean
  end
end
