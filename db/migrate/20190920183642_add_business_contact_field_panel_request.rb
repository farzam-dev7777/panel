class AddBusinessContactFieldPanelRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :panel_requests, :business_manager_name, :string
    add_column :panel_requests, :business_manager_phone, :string
    add_column :panel_requests, :business_manager_email, :string
  end
end
