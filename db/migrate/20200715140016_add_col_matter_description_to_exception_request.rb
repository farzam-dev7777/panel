class AddColMatterDescriptionToExceptionRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :exception_requests, :matter_description, :string
  end
end
