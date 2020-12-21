class ChangeColPanelRequestsFirmUseOnRegularBasis < ActiveRecord::Migration[5.0]
  def up
    change_column :panel_requests, :firm_use_on_regular_basis, :string, :using => "case when firm_use_on_regular_basis then 'Yes' else 'No' end", default: nil
  end

  def down
    change_column :panel_requests, :firm_use_on_regular_basis, 'boolean USING CAST(firm_use_on_regular_basis AS boolean)', default: nil
  end
end
