class Country < ApplicationRecord
  has_many :law_firms_countries
  has_many :law_firms, :through => :law_firms_countries

  def self.ransackable_attributes(auth_object = nil)
    ["country_id", "created_at", "id", "iso", "name", "position", "updated_at"]
  end
end
