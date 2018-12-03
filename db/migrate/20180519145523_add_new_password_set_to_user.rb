class AddNewPasswordSetToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :new_password_set, :boolean, default: false
  end
end
