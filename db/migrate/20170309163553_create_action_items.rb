class CreateActionItems < ActiveRecord::Migration[5.0]
  def change
    create_table :action_items do |t|
      t.integer :security_threat_id
      t.integer :law_firm_id
      t.string :status

      t.timestamps
    end
  end
end
