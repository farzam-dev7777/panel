class CreateConflictWaiversTable < ActiveRecord::Migration[5.0]
  def change
    create_table :conflict_waivers do |t|
      t.string :name_of_law_firm
      t.string :contact_details
      t.string :bmo_business_contact
      t.text :reason
      t.integer :user_id

      t.timestamps
    end
  end
end
