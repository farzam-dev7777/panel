class AddReviewerEmailColumnToMatterIntake < ActiveRecord::Migration[5.0]
  def change
    add_column :matter_intakes, :reviewer_email, :string
    add_column :invoices, :status, :string
    add_column :invoices, :date, :date
    add_column :invoices, :taxes, :integer
  end
end
