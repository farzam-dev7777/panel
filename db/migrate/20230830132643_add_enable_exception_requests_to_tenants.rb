class AddEnableExceptionRequestsToTenants < ActiveRecord::Migration[5.0]
  def change
    add_column :tenants, :enable_exception_requests, :boolean, default: true
  end
end
