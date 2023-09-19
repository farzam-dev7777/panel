class LawFirmsTenant < ApplicationRecord

  belongs_to :law_firm
  belongs_to :tenant

  mount_uploader :document, FileUploader
end
