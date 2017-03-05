class AddLawFirmIdToTechnology < ActiveRecord::Migration[5.0]
  def change
    add_column :technology_values, :law_firm_id, :integer
    add_column :technology_values, :submission_id, :integer
  end
end
