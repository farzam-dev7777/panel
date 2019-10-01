class AddStatusFieldIntoExceptionRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :exception_requests, :lxp_status, :string
    add_column :exception_requests, :lxp_id, :integer
    add_column :exception_requests, :internal_lawyers_status, :string
    add_column :exception_requests, :internal_lawyers_id, :integer
  end
end
