class Location < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["address1", "address2", "city", "country", "created_at", "id", "law_firm_id", "postal_code", "province", "updated_at"]
  end
end
