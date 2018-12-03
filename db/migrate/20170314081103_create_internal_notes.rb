class CreateInternalNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :internal_notes do |t|
      t.text :message
      t.integer :sender_id
      t.integer :law_firm_id

      t.timestamps
    end
  end
end
