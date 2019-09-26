class AddStatusFieldIntoConflictWaivers < ActiveRecord::Migration[5.0]
  def change
    add_column :conflict_waivers, :lxp_status, :string
    add_column :conflict_waivers, :internal_lawyers_status, :string
  end
end
