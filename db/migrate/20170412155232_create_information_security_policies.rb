class CreateInformationSecurityPolicies < ActiveRecord::Migration[5.0]
  def change
    create_table :information_security_policies do |t|
      t.string :policy
      t.date :last_reviewed
      t.date :last_updated
      t.string :freq_of_review
      t.integer :form_value_id

      t.timestamps
    end
  end
end
