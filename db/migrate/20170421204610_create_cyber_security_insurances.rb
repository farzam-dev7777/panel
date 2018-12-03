class CreateCyberSecurityInsurances < ActiveRecord::Migration[5.0]
  def change
    create_table :cyber_security_insurances do |t|
      t.string :company
      t.string :coverage
      t.string :coverage_amount
      t.string :policy
      t.string :form_value_id

      t.timestamps
    end
  end
end
