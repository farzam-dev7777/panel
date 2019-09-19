class AddLawFirmNameFieldIntoExceptionRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :exception_requests, :law_firm_name, :string
  end
end
