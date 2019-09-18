class CreatePanelRequestTable < ActiveRecord::Migration[5.0]
  def change
    create_table :panel_requests do |t|
      t.string :requested_by
      t.integer :user_id
      t.string :submitted_by_email
      t.string :line_of_business
      t.string :lob_contact_name
      t.integer :law_firm_id
      t.string :request_type
      t.string :law_firm_category
      t.string :minority_owned
      t.text :minority_owned_details
      t.string :women_owned
      t.text :women_owned_details
      t.string :matter_name
      t.text :matter_types
      t.timestamps
    end
  end
end
