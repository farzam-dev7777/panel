class AddCheckedToTechnologyValye < ActiveRecord::Migration[5.0]
  def change
    add_column :technology_values, :checked, :boolean, default: false
    add_column :history_submissions, :checked, :boolean, default: false
    add_column :form_values, :checked, :boolean, default: false
  end
end
