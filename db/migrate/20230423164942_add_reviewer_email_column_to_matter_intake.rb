class AddReviewerEmailColumnToMatterIntake < ActiveRecord::Migration[5.0]
  def change
    add_column :matter_intakes, :reviewer_email, :string
    add_column :invoices, :status, :string
  end
end
