class SubMatterType < ApplicationRecord
  has_many :law_firms_sub_matter_types
  has_many :law_firms, :through => :law_firms_sub_matter_types
end

