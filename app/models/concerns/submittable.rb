module Submittable
  extend ActiveSupport::Concern

  included do
    has_many :form_values, as: :submittable
    belongs_to :form
    accepts_nested_attributes_for :form_values, allow_destroy: false
    belongs_to :form_process, class_name: Form
    belongs_to :form_policy, class_name: Form, foreign_key: 'form_id'
  end

  def build_values(form_fields, step = 'policy')
    form_fields = form_fields || self.send("form_#{step}").form_fields.top_form_fields
    form_fields.map do |form_field|
      self.form_values.find_or_create_by(form_field_label: form_field.label, form_field: form_field, submittable_id: self.id)
    end
  end

  def form_value_errors
    self.errors.full_messages
  end
end