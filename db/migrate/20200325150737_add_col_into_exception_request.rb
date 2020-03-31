class AddColIntoExceptionRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :exception_requests, :is_work, :boolean, default: false
    add_column :exception_requests, :reason, :text
    add_column :exception_requests, :payer, :string
    add_column :exception_requests, :matter_types_search, :text
    add_column :exception_requests, :sub_matter_types_search, :text
    add_column :exception_requests, :jurisdiction_types_search, :text
    add_column :exception_requests, :countries_search, :text
    add_column :exception_requests, :states_search, :text
  end
end
