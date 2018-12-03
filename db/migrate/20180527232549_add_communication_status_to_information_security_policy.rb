class AddCommunicationStatusToInformationSecurityPolicy < ActiveRecord::Migration[5.0]
  def change
    add_column :information_security_policies, :communication_status, :string
  end
end
