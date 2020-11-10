class ChangeTableNameLawFirmFeedbackToFeedbacks < ActiveRecord::Migration[5.0]
  def up
    rename_table :law_firms_feedbacks, :feedbacks
  end

  def down
    rename_table :feedbacks, :law_firms_feedbacks
  end
end
