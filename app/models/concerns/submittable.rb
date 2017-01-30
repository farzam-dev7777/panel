module Submittable
  extend ActiveSupport::Concern

  included do
    has_many :form_values, as: :submittable
    accepts_nested_attributes_for :form_values, allow_destroy: true
  end
end