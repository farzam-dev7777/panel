class AddNewColsToCyberSecurityInsurance < ActiveRecord::Migration[5.0]
  def change
    add_column :cyber_security_insurances, :date_of_expiry, :date
    add_column :cyber_security_insurances, :standing, :string
  end
end
