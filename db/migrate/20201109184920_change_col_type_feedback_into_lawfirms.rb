class ChangeColTypeFeedbackIntoLawfirms < ActiveRecord::Migration[5.0]
  def up
    change_column :law_firms, :value_add_activities, :text
    change_column :law_firms, :feedback, :text
    change_column :law_firms, :issues, :text
  end

  def down
    change_column :law_firms, :value_add_activities, :string
    change_column :law_firms, :feedback, :string
    change_column :law_firms, :issues, :string
  end
end