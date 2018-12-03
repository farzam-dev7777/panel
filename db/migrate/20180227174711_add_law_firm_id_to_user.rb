class AddLawFirmIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :law_firm_id, :integer
  end
end
