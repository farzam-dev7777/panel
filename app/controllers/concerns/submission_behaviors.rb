module SubmissionBehaviors
  extend ActiveSupport::Concern

  def form_values_attributes
    [form_values_attributes: [:form_field_id, :value]]
  end
end