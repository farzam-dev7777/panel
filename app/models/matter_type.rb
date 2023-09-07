class MatterType < ApplicationRecord
  #has_many 		:sub_matter_types
  has_many :law_firms_matter_types
  has_many :law_firms, :through => :law_firms_matter_types
  has_many :matter_intakes

  def self.lb_records
    Apartment::Tenant.switch('lb') do
      MatterType.all
    end
  end
end

