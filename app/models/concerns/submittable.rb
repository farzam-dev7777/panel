module Submittable
  extend ActiveSupport::Concern

  included do
    has_many :form_values, as: :submittable
    accepts_nested_attributes_for :form_values, allow_destroy: true
  end

  def build_values(form_fields = self.form_fields.top_form_fields, form = self)
    @form_values = form_fields.map do |form_field|
      form_field.form_values.build(form_field_label: form_field.label, submittable: form)
    end
    self.form_values = @form_values
  end
end