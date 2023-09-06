class AddInternalLawyerLabelToTenants < ActiveRecord::Migration[5.0]
  def change
    add_column :tenants, :internal_lawyer_label, :string
  end
end
