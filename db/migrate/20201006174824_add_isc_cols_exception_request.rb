class AddIscColsExceptionRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :exception_requests, :receive_personal_information, :string
    add_column :exception_requests, :receive_general_business_data, :string
    add_column :exception_requests, :applicable_technical_specialty_data, :string
    add_column :exception_requests, :receive_personal_information_data_type, :text
    add_column :exception_requests, :receive_general_business_data_type, :text
    add_column :exception_requests, :applicable_technical_specialty_data_type, :text
  end
end
