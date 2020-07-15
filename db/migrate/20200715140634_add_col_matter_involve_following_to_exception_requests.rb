class AddColMatterInvolveFollowingToExceptionRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :exception_requests, :matter_involve_following, :string
  end
end
