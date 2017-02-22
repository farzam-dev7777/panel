class AddStepToForms < ActiveRecord::Migration[5.0]
  def change
    add_column :forms, :step, :string
  end
end
