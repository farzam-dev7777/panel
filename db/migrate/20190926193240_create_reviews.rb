class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :reviewable_id
      t.string :reviewable_type
      t.string :status
      t.string :status_from
      t.text :description
      t.integer :actor_id
      t.integer :assigned_to_id

      t.timestamps
    end
  end
end
