class AddIndependentReviewToInformationSecurityPolicy < ActiveRecord::Migration[5.0]
  def change
    add_column :information_security_policies, :independent_review, :string
  end
end
