class AddApprovedAtToFormSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :form_submissions, :approved_at, :datetime

    FormSubmission.where.not(expiry_date: nil).each do |fs|
      fs.approved_at = fs.expiry_date - 1.year
      fs.save
    end
  end
end
