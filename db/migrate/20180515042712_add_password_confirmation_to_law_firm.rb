class AddPasswordConfirmationToLawFirm < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :temp_password_confirmation, :string
  end
end
