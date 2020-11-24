module Submittable
  extend ActiveSupport::Concern

  included do
    has_many :form_values, as: :submittable
    belongs_to :form
    accepts_nested_attributes_for :form_values, allow_destroy: false
    belongs_to :form_pricing, class_name: Form, foreign_key: 'form_id'
    belongs_to :form_relationship, class_name: Form, foreign_key: 'form_relationship_id'
    belongs_to :form_diversity, class_name: Form, foreign_key: 'form_diversity_id'
    belongs_to :form_innovation, class_name: Form, foreign_key: 'form_innovation_id'
    belongs_to :form_resourcing, class_name: Form, foreign_key: 'form_resourcing_id'
    belongs_to :form_lawfirm, class_name: Form, foreign_key: 'form_lawfirm_id'
  end

  def build_values(form_fields, step = 'pricing')
    form_fields = form_fields || self.send("form_#{step}").form_fields.top_form_fields
    form_fields.map do |form_field|
      self.form_values.find_or_create_by(form_field_label: form_field.label, form_field: form_field, submittable_id: self.id)
    end
  end

  def form_value_errors
    self.errors.full_messages
  end
end