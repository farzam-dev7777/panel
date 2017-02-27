class FormSubmission < ApplicationRecord
  include Submittable
  has_many :technology_values
	accepts_nested_attributes_for :technology_values

end
