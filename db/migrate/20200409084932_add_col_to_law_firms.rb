class AddColToLawFirms < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :status, :string
  end
end
