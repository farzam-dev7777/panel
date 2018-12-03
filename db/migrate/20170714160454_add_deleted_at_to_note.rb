class AddDeletedAtToNote < ActiveRecord::Migration[5.0]
  def change
    add_column :notes, :deleted_at, :datetime
  end
end
