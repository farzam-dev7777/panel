class AddColModeOfPaymentToExceptionRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :exception_requests, :mode_of_payment, :string
  end
end