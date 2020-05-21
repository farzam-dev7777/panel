class UpdateBusinessContactFieldExceptionRequest < ActiveRecord::Migration[5.0]
  def up
    rename_column :exception_requests, :relationship_manager_name, :business_manager_name
    rename_column :exception_requests, :relationship_manager_phone, :business_manager_phone
    rename_column :exception_requests, :relationship_manager_email, :business_manager_email
  end
end
