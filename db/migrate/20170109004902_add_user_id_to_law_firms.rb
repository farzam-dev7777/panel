class AddUserIdToLawFirms < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :user_id, :integer
  end
end
