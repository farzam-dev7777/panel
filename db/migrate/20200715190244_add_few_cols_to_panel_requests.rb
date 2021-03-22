class AddFewColsToPanelRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :panel_requests, :niche_preferred_external_counsel_panel_law_firms, :boolean, default: false
    add_column :panel_requests, :niche_expertise, :text
    add_column :panel_requests, :required_unique_geography, :boolean, default: false
    add_column :panel_requests, :geographic_location, :text
    add_column :panel_requests, :involved_engagement, :string
    add_column :panel_requests, :reason_other, :text
  end
end
