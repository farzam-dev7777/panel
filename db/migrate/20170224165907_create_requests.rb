class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :type
      t.integer :law_firm_id

      t.timestamps
    end
  end
end
