class AddScoreToDropwdownOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :dropdown_options, :score, :float, default: 0.0
  end
end
