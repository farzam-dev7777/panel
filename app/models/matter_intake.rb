class MatterIntake < ApplicationRecord

  self.per_page = 10
  belongs_to :user
  belongs_to :law_firm
  belongs_to :matter_type

  validates_presence_of :submitter_name, :matter_type_id

end
