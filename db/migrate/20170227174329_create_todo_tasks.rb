class CreateTodoTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :todo_tasks do |t|
      t.integer :law_firm_id
      t.string :title
      t.string :message
      t.string :severity

      t.timestamps
    end
  end
end
