class AddLawFirmColToPanelRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :panel_requests, :law_frim_name, :string
    add_column :panel_requests, :law_firm_contact_name, :string
    add_column :panel_requests, :law_firm_mail, :string
    add_column :panel_requests, :law_firm_role, :string
    add_column :panel_requests, :law_firm_phone, :string
    add_column :panel_requests, :firm_use_on_regular_basis, :boolean, default: false
    add_column :panel_requests, :archived_at, :datetime, default: nil
  end
end
