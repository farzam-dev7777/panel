class LawFirmsMatterType < ApplicationRecord
  belongs_to :law_firm
  belongs_to :matter_type
end
