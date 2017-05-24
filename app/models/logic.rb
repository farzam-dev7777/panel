class Logic < ApplicationRecord
  LOGIC_TO_BE_APPLIED = ["when"] #, "greater_than", "less_than", "between"
  PERFORM_ACTION = ["show"] #, "hide"

  belongs_to :listen_field, foreign_key: 'listen_field_id', class_name: FormField
  belongs_to :change_field, foreign_key: 'change_field_id', class_name: FormField
  belongs_to :form, class_name: Form

  REPEATER_FIELDS = ['CyberSecurityStandardField',
  									 'ThirdPartyVendorField',
  								 	 'CloudProviderField',
                     'InformationSecurityPolicyField',
  								 	 'CyberSecurityInsuranceField',
                     'ActivityTimeLogField'
  								 	].freeze

  def repeater_field
  	REPEATER_FIELDS.include? self.listen_field.type 
  end

end
