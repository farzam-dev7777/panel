class FormValue < ApplicationRecord

  belongs_to :form_field
  belongs_to :submittable, polymorphic: true
  has_many   :file_attachments
  has_many   :vendors
  has_many   :cyber_security_standards
  has_many   :information_security_policies
  has_many   :third_party_vendors

  # mount_uploader :file_value, FileUploader

  validate :value_is_valid

  accepts_nested_attributes_for :file_attachments, allow_destroy: true
  accepts_nested_attributes_for :vendors, allow_destroy: true
  accepts_nested_attributes_for :cyber_security_standards, allow_destroy: true
  accepts_nested_attributes_for :information_security_policies, allow_destroy: true
  accepts_nested_attributes_for :third_party_vendors, allow_destroy: true

  def file_cache

  end

  def build_nested_form_values(step)
    self.submittable.build_values(self.form_field.children, step)
  end

  private

  def value_is_valid
    form_field.validate_value(self) if form_field
  end


end
