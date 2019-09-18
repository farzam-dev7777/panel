class AddConfirmWaiverFieldToConflictWaivers < ActiveRecord::Migration[5.0]
  def change
    add_column :conflict_waivers, :confirm_waiver, :boolean
  end
end
