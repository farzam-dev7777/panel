class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :proposal_id
      t.integer :question_id
      t.integer :rfp_id
      t.text :response
      t.datetime :date
      t.string :file
      t.timestamps
    end
  end
end
