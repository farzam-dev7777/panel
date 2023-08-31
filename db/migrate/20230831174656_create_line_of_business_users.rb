class CreateLineOfBusinessUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :line_of_business_users do |t|
      t.integer :user_id
      t.integer :line_of_business_id

      t.timestamps
    end
  end
end
