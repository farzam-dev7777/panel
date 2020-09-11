class ChangeColTypeIsWorkInExceptionRequests < ActiveRecord::Migration[5.0]
  def up
    change_column :exception_requests, :is_work, :string, :using => "case when is_work then 'Yes' else 'No' end", default: nil
  end

  def down
    change_column :exception_requests, :is_work, 'boolean USING CAST(is_work AS boolean)', default: nil
  end
end
