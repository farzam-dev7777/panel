class Country < ApplicationRecord
  has_many :law_firms_countries
  has_many :law_firms, :through => :law_firms_countries
end
