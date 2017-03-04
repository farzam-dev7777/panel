class CreateFollowUps < ActiveRecord::Migration[5.0]
  def change
    create_table :follow_ups do |t|
      t.integer :form_submission_id
      t.string :loggable_type
      t.integer :loggable_id
      t.string :status
      t.integer :note_id

      t.timestamps
    end
  end
end
