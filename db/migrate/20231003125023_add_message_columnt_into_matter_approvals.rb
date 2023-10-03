class AddMessageColumntIntoMatterApprovals < ActiveRecord::Migration[5.0]
  def change
    add_column :matter_approvals, :message, :text
  end
end
