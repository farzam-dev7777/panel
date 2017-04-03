class CreateCyberSecurityStandards < ActiveRecord::Migration[5.0]
  def change
    create_table :cyber_security_standards do |t|
      t.string :rank
      t.string :standard
      t.date :date_of_certification
      t.date :renewal
      t.integer :form_value_id

      t.timestamps
    end
  end
end
