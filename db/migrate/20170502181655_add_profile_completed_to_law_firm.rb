class AddProfileCompletedToLawFirm < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :profile_completed, :boolean, default: false
  end
end
