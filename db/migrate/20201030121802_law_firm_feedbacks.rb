class LawFirmFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :law_firms_feedbacks, :id => false do |t|
      t.integer :law_firm_id
      t.integer :feedbacks_id
      t.string :feedback
      t.timestamps
    end
  end
end

