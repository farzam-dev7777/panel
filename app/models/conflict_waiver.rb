class ConflictWaiver < ApplicationRecord

  self.per_page = 10
  belongs_to :user
  belongs_to :law_firm

  validates_presence_of :name_of_law_firm, :contact_details, :bmo_business_contact, :reason

end
