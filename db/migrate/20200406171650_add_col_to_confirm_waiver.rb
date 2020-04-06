class AddColToConfirmWaiver < ActiveRecord::Migration[5.0]
  def change
    add_column :conflict_waivers, :retainer_language, :text
  end
end

