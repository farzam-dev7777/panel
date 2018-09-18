class AddQrCodeConfirmedAtToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :qr_code_confirmed_at, :datetime
  end
end
