class AddColReasonDetailsToExceptionRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :exception_requests, :reason_details, :text
  end
end
