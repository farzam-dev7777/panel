class AddColToExceptionRequest < ActiveRecord::Migration[5.0]
  def change 
    add_column :exception_requests, :niche_preferred_external_counsel_panel_law_firms, :boolean, default: false
    add_column :exception_requests, :niche_expertise, :text
    add_column :exception_requests, :required_unique_geography, :boolean, default: false
    add_column :exception_requests, :geographic_location, :text
    add_column :exception_requests, :involved_engagement, :string
    add_column :exception_requests, :reson_other, :text
  end
end
