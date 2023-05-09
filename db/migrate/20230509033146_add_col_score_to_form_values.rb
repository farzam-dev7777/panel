class AddColScoreToFormValues < ActiveRecord::Migration[5.0]
  def change
    add_column :form_values, :score, :float, default: 0.0
  end
end
