class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.integer :matter_intake_id
      t.string :lawyer_name
      t.float :rate, default: 0.0
      t.string :rate_type
      t.string :description
      t.float :hours
      t.monetize :amount, limit: 8, default: 0, null: false

      t.timestamps
    end
  end
end
