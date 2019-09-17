class AddMatterTypesToExceptionRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :exception_requests, :matter_types, :text
  end
end
