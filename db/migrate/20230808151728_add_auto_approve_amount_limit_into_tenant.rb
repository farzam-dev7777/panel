class AddAutoApproveAmountLimitIntoTenant < ActiveRecord::Migration[5.0]
  def change
    add_column :tenants, :auto_approve_amount_limit, :integer
    add_column :tenants, :auto_approve_matter_type, :string
    add_column :tenants, :matter_first_approval, :string
    add_column :tenants, :matter_second_approval, :string
    add_column :tenants, :matter_third_approval, :string
  end
end
