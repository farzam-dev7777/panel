class LawFirmsJurisdictionType < ApplicationRecord
  belongs_to :law_firm
  belongs_to :jurisdiction_type
end
