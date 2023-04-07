class CreateLawFirmsTenants < ActiveRecord::Migration[5.0]
  def change
    create_table :law_firms_tenants do |t|
      t.integer :law_firm_id
      t.integer :tenant_id

      t.timestamps
    end
  end
end
