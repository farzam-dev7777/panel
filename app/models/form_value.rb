class FormValue < ApplicationRecord
  include HasAttachedFiles

  belongs_to :form_field
  belongs_to :submittable, polymorphic: true
  has_many   :file_attachments, dependent: :destroy
  has_many   :vendors, dependent: :destroy
  has_many   :cyber_security_standards, dependent: :destroy
  has_many   :information_security_policies, dependent: :destroy
  has_many   :third_party_vendors, dependent: :destroy
  has_many   :cloud_providers, dependent: :destroy
  has_many   :shared_bank_informations, dependent: :destroy
  has_many   :cyber_security_insurances, dependent: :destroy
  has_one    :activity_time_log, dependent: :destroy

  serialize :multi_select_value, Array

  # mount_uploader :file_value, FileUploader

  validate :value_is_valid

  accepts_nested_attributes_for :file_attachments, allow_destroy: true
  accepts_nested_attributes_for :activity_time_log, allow_destroy: true
  accepts_nested_attributes_for :vendors, allow_destroy: true
  accepts_nested_attributes_for :shared_bank_informations,
                                allow_destroy: true,
                                reject_if: proc { |attributes| attributes['name'].blank? && attributes['purpose'].blank? && attributes['level_of_access'].blank? }
  accepts_nested_attributes_for :cyber_security_standards, 
                                allow_destroy: true,
                                reject_if: proc { |attributes| attributes['rank'].blank? && attributes['standard'].blank? && attributes['date_of_certification'].blank? && attributes['renewal'].blank? }
  accepts_nested_attributes_for :information_security_policies, 
                                allow_destroy: true,
                                reject_if: proc { |attributes| attributes['policy'].blank? && attributes['last_reviewed'].blank? && attributes['last_updated'].blank? && attributes['freq_of_review'].blank? }
  accepts_nested_attributes_for :third_party_vendors, 
                                allow_destroy: true,
                                reject_if: proc { |attributes| attributes['vendor_name'].blank? && attributes['area'].blank? && attributes['confidentiality_agreement'].blank? }
  accepts_nested_attributes_for :cloud_providers, 
                                allow_destroy: true,
                                reject_if: proc { |attributes| attributes['name'].blank? && attributes['service'].blank? && attributes['data_store_location_ca'].blank? && attributes['cloud_type'].blank? && attributes['data'].blank? && attributes['encrypted_in_flight'].blank? && attributes['encrypted_at_rest'].blank? }
  accepts_nested_attributes_for :cyber_security_insurances, 
                                allow_destroy: true,
                                reject_if: proc { |attributes| attributes['company'].blank? && attributes['coverage'].blank? && attributes['coverage_amount'].blank? && attributes['date_of_expiry'].blank? && attributes['standing'].blank? }

  def file_cache

  end

  def build_nested_form_values(step)
    self.submittable.build_values(self.form_field.children, step)
  end

  def render_information_security_policy_fields
    self.information_security_policies.any? ? self.information_security_policies : [self.information_security_policies.build]
  end

  def render_cyber_security_standard_fields
    self.cyber_security_standards.any? ? self.cyber_security_standards : [self.cyber_security_standards.build]
  end

  def render_third_party_vendor_fields
    self.third_party_vendors.any? ? self.third_party_vendors : [self.third_party_vendors.build]
  end

  def render_cloud_provider_fields
    self.cloud_providers.any? ? self.cloud_providers : [self.cloud_providers.build]
  end

  def render_activity_time_log_fields
    self.activity_time_log ? self.activity_time_log : self.activity_time_log.build
  end

  def render_cyber_security_insurance_fields
    self.cyber_security_insurances.any? ? self.cyber_security_insurances : [self.cyber_security_insurances.build]
  end

  def render_shared_bank_information_fields
    self.shared_bank_informations.any? ? self.shared_bank_informations : [self.shared_bank_informations.build]
  end

  def is_a_repeater_field?
    Logic::REPEATER_FIELDS.include? self.try(:form_field).try(:type) 
  end

  def form_value_id
    self.id
  end

  private

  def value_is_valid
    form_field.validate_value(self) if form_field
  end


end
