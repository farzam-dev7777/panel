class AddBusinessContactFieldExceptionRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :exception_requests, :relationship_manager_name, :string
    add_column :exception_requests, :relationship_manager_phone, :string
    add_column :exception_requests, :relationship_manager_email, :string

  end
end