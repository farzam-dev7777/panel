class AddUpdatedByLawfirmToLawFirm < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :updated_by_lawfirm, :boolean, default: false
  end
end
