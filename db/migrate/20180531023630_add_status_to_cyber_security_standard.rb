class AddStatusToCyberSecurityStandard < ActiveRecord::Migration[5.0]
  def change
    add_column :cyber_security_standards, :status, :string
  end
end
