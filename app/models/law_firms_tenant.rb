class LawFirmsTenant < ApplicationRecord

  belongs_to :law_firm
  belongs_to :tenant

end
