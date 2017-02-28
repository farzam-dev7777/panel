class FormSubmission < ApplicationRecord
  include Submittable
  has_many :technology_values
  has_many :history_submissions
	accepts_nested_attributes_for :technology_values
	accepts_nested_attributes_for :history_submissions

end
