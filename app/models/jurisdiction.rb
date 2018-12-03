class Jurisdiction < ApplicationRecord
	belongs_to :law_firm
  serialize :city, Array
end
