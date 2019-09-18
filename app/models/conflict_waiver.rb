class ConflictWaiver < ApplicationRecord

  self.per_page = 10
  belongs_to :user
  belongs_to :law_firm

  validates_presence_of :name_of_law_firm, :contact_details, :bmo_business_contact, :reason

  validate :confirm_waiver_must_be_true

  
  def confirm_waiver_must_be_true
    errors.add(:confirm_waiver, "you must confirm that this waiver is not covered by the above waivers") if self.confirm_waiver != true
  end

  

end
