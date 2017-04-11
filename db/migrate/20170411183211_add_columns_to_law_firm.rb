class AddColumnsToLawFirm < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :law_firm_type, :string
    add_column :law_firms, :parent_company, :text
    add_column :law_firms, :practice_area, :string
    add_column :law_firms, :sister_firm, :text
    add_column :law_firms, :principle_name, :string
    add_column :law_firms, :principle_title, :string
    add_column :law_firms, :principle_contact_info, :text
  end
end
