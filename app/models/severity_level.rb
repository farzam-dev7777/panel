class SeverityLevel < ApplicationRecord
	has_many 	:triggers
	accepts_nested_attributes_for :triggers
end
