class Add2faKeyToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :two_fa_key, :string
    add_column :users, :two_fa_key_expires_at, :datetime
  end
end
