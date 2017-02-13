class FormValue < ApplicationRecord

  belongs_to :form_field
  belongs_to :submittable, polymorphic: true

  validate :value_is_valid

  def file_cache

  end

  def build_nested_form_values
    self.submittable.build_values(self.form_field.children)
  end

  private

  def value_is_valid
    form_field.validate_value(self)
  end


end
