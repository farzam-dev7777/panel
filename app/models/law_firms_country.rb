class LawFirmsCountry < ApplicationRecord
  belongs_to :law_firm
  belongs_to :country
end
