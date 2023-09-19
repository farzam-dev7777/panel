class AddDocumentColumnToLawFirmTenant < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms_tenants, :document, :string
    add_column :law_firms_tenants, :status, :string
  end
end
