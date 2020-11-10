class AddColAssignedToIdComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :assigned_to_id, :integer
  end
end
