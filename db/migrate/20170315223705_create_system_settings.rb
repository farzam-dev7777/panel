class CreateSystemSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :system_settings do |t|
      t.float :score_threshold

      t.timestamps
    end
  end
end
