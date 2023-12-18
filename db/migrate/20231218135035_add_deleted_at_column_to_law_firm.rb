class AddDeletedAtColumnToLawFirm < ActiveRecord::Migration[7.0]
  def change
    add_column :law_firms, :deleted_at, :datetime
  end
end
