class State < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["country_id", "created_at", "id", "iso", "name", "updated_at"]
  end
end
