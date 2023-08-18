class CreateTenantMatterApprovals < ActiveRecord::Migration[5.0]
  def change
    create_table :tenant_matter_approvals do |t|
      t.string :approval_type
      t.string :owner_role
      t.string :role
      t.boolean :approval
      t.boolean :notification
      t.integer :tenant_id
      t.string :title
      t.integer :sequence_number
      t.timestamps
    end
  end
end
