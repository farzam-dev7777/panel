class ChangeColTypeInPanelRequests < ActiveRecord::Migration[5.0]
  def up
    change_column :panel_requests, :niche_preferred_external_counsel_panel_law_firms, :string, :using => "case when niche_preferred_external_counsel_panel_law_firms then 'Yes' else 'No' end", default: nil
    change_column :panel_requests, :required_unique_geography, :string, :using => "case when required_unique_geography then 'Yes' else 'No' end", default: nil
  end

  def down
    change_column :panel_requests, :niche_preferred_external_counsel_panel_law_firms, 'boolean USING CAST(niche_preferred_external_counsel_panel_law_firms AS boolean)', default: nil
    change_column :panel_requests, :required_unique_geography, 'boolean USING CAST(required_unique_geography AS boolean)', default: nil
  end
end
