class CreateProposalComments < ActiveRecord::Migration[7.0]
  def change
    create_table :proposal_comments do |t|
      t.integer :proposal_id
      t.integer :user_id
      t.text :message 
      t.timestamps
    end
  end
end
