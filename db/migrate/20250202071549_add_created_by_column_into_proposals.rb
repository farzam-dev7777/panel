class AddCreatedByColumnIntoProposals < ActiveRecord::Migration[7.0]
  def change
    add_column :proposals, :created_by_id, :integer
    add_column :proposals, :updated_by_id, :integer
  end
end
