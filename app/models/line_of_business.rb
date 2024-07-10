class LineOfBusiness < ApplicationRecord
    belongs_to :tenant
    has_many :line_of_business_users
    has_many :users, :through => :line_of_business_users

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "name", "sso_group", "tenant_id", "updated_at"]
  end
end
