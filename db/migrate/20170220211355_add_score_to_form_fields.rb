class AddScoreToFormFields < ActiveRecord::Migration[5.0]
  def change
    add_column :form_fields, :scored, :boolean
    add_column :form_fields, :score, :float
  end
end
