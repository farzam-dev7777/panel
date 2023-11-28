class LawFirmsTenant < ApplicationRecord

  belongs_to :law_firm
  belongs_to :tenant

  mount_uploader :document, FileUploader
  serialize :type_of_matters_your_law_firm_handles_for_us, Array

  def self.ransackable_associations(auth_object = nil)
    ["law_firm", "tenant"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["type_of_matters_your_law_firm_handles_for_us", "country_id", "created_at", "id", "iso", "name", "position", "updated_at"]
  end

  def allow_to_matters
    if allow_to_create_matters == true
      'Yes'
    elsif allow_to_create_matters == false
      'No'
    end
  end
end
