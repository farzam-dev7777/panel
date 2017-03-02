class FormSubmission < ApplicationRecord
  include Submittable
  belongs_to :law_firm
  has_many :technology_values
  has_many :history_submissions
  has_many :notes
	accepts_nested_attributes_for :technology_values
	accepts_nested_attributes_for :history_submissions

end
