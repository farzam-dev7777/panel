class AddLawFirmNameFieldIntoPanelRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :panel_requests, :law_firm_name, :string
  end
end
