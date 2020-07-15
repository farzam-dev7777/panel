class AddColJurisdictionToExceptionRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :exception_requests, :jurisdiction, :string
  end
end
