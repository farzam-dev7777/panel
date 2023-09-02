class CreateLineOfBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :line_of_businesses do |t|
      t.string :sso_group
      t.string :name
      t.integer :tenant_id

      t.timestamps
    end
  end
end
