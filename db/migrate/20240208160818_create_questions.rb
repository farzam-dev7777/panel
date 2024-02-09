class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.integer :rfp_id
      t.text :message
      t.string :kind
      t.timestamps
    end
  end
end
