class RemoveTempPasswordConfirmationFieldFromLawFirm < ActiveRecord::Migration[5.0]
  def up
    remove_column :law_firms, :temp_password_confirmation
  end
end
