class CreateMatterApprovals < ActiveRecord::Migration[5.0]
  def change
    create_table :matter_approvals do |t|
      t.integer :user_id
      t.string :approve_by_role
      t.string :status
      t.integer :matter_intake_id
      t.integer :approval_sequence
      t.string :approval_type

      t.timestamps
    end
  end
end
