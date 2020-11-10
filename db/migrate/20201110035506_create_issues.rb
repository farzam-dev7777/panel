class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues , :id => false do |t|
      t.integer :law_firm_id
      t.integer :issues_id
      t.string :issue
      t.timestamps
    end
  end
end