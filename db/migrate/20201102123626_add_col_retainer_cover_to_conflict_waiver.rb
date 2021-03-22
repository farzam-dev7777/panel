class AddColRetainerCoverToConflictWaiver < ActiveRecord::Migration[5.0]
  def change
    add_column :conflict_waivers, :retainer_cover, :text
  end
end
