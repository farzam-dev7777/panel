class UpdateMinorityOwnedAndWomenOwnedFieldToTextInExceptionRequestsTable < ActiveRecord::Migration[5.0]
  def up
    change_column :exception_requests, :minority_owned, :string
    change_column :exception_requests, :women_owned, :string
  end
end