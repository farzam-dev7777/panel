class AddPayTypeFieldIntoExceptionRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :exception_requests, :pay_type, :string
  end
end
