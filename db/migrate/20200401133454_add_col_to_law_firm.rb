class AddColToLawFirm < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :firm_use_on_regular_basis, :boolean, default: false
  end
end
