class AddColPanelStatusToLawFirms < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :panel_status, :string
  end
end
