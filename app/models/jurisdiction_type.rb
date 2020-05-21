class JurisdictionType < ApplicationRecord
  has_many :law_firms_jurisdiction_types
  has_many :law_firms, :through => :law_firms_jurisdiction_types
end

