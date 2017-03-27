class RemoveColumnsFromUsers < ActiveRecord::Migration[5.0]
  def change
  	remove_column :users, :gauth_secret
  	remove_column :users, :gauth_enabled
  	remove_column :users, :gauth_tmp
  	remove_column :users, :gauth_tmp_datetime
  	remove_column :users, :encrypted_otp_secret
  	remove_column :users, :encrypted_otp_secret_iv
  	remove_column :users, :encrypted_otp_secret_salt
  	remove_column :users, :consumed_timestep
  	remove_column :users, :otp_required_for_login
  end
end










