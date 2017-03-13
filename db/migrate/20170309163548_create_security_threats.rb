class CreateSecurityThreats < ActiveRecord::Migration[5.0]
  def change
    create_table :security_threats do |t|
      t.string :title
      t.text :description
      t.integer :severity_level_id

      t.timestamps
    end
  end
end
