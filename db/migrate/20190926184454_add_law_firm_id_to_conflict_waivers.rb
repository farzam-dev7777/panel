class AddLawFirmIdToConflictWaivers < ActiveRecord::Migration[5.0]
  def change
    add_column :conflict_waivers, :law_firm_id, :integer
  end
end
