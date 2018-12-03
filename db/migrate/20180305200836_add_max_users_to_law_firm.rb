class AddMaxUsersToLawFirm < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :max_users, :integer
  end
end
