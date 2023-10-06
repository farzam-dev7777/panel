class ExternalLawyer < ApplicationRecord

  belongs_to :law_firm
  has_many :external_lawyer_matter_intakes
  has_many :matter_intakes, :through => :external_lawyer_matter_intakes
end
