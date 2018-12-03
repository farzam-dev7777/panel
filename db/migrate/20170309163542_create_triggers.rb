class CreateTriggers < ActiveRecord::Migration[5.0]
  def change
    create_table :triggers do |t|
      t.integer :hours
      t.string :action_type
      t.string :message
      t.integer :severity_level_id

      t.timestamps
    end
  end
end
