class AddPanelRequestTenantAdmin < ActiveRecord::Migration[5.0]
  def change
    add_column :tenants, :allow_panel_consideration_lob_Lawyers, :boolean
    add_column :tenants, :system_score_threshold, :string
  end
end
