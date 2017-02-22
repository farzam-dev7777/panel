module Submittable
  extend ActiveSupport::Concern

  included do
    has_many :form_values, as: :submittable
    belongs_to :form
    accepts_nested_attributes_for :form_values, allow_destroy: false
  end

  def build_values(form_fields = self.form.form_fields.top_form_fields)
    form_fields.map do |form_field|
      self.form_values.find_or_initialize_by(form_field_label: form_field.label, form_field: form_field, submittable_id: self.id)
    end
  end

  def form_value_errors
    self.errors.full_messages
  end
end