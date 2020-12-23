class AddLawfirmColToExceptionRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :exception_requests, :law_firm_name, :string
    add_column :exception_requests, :law_firm_email, :string
    add_column :exception_requests, :law_firm_phone, :string
    add_column :exception_requests, :firm_use_on_regular_basis, :string
  end
end
