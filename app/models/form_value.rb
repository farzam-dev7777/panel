class FormValue < ApplicationRecord

  belongs_to :form_field
  belongs_to :submittable, polymorphic: true
  has_many   :file_attachments

  # mount_uploader :file_value, FileUploader

  validate :value_is_valid

  accepts_nested_attributes_for :file_attachments, allow_destroy: true

  def file_cache

  end

  def build_nested_form_values(step)
    self.submittable.build_values(self.form_field.children, step)
  end

  private

  def value_is_valid
    form_field.validate_value(self)
  end


end
