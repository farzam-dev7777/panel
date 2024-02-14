class CreateTenantQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :tenant_questions do |t|
      t.integer :tenant_id
      t.text :title
      t.string :kind
      t.timestamps
    end
  end
end
