class LineOfBusiness < ApplicationRecord
	belongs_to :tenant
	has_many :line_of_business_users
	has_many :users, :through => :line_of_business_users
end
