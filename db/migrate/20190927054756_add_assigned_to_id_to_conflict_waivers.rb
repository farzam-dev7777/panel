class AddAssignedToIdToConflictWaivers < ActiveRecord::Migration[5.0]
  def change
    add_column :conflict_waivers, :assigned_to_id, :integer
  end
end
