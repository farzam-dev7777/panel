class AddUploadPolicyToInformationSecurityPolicy < ActiveRecord::Migration[5.0]
  def change
    add_column :information_security_policies, :upload_policy, :string
  end
end
