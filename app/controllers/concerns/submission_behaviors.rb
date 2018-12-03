module SubmissionBehaviors
  extend ActiveSupport::Concern

  def form_values_attributes
    [
    	form_values_attributes: [
                                :id, :file_ids, :form_field_id, :value, :submittable_id, :submittable_type, :form_field_label, :file_value, multi_select_value: [], 
      													file_attachments_attributes: [:id, :file], 
                                vendors_attributes: [:id, :name, :vendor_type, :application, :_destroy],
                                cyber_security_standards_attributes: [:id, :file_ids, :rank, :standard, :date_of_certification, :renewal, :_destroy, :status], 
                                information_security_policies_attributes: [:id, :independent_review, :file_ids, :policy, :last_reviewed, :last_updated, :freq_of_review, :_destroy, :communication_status],
                                third_party_vendors_attributes: [:id, :file_ids, :vendor_name, :area, :confidentiality_agreement, :_destroy], 
                                cloud_providers_attributes: [:id, :file_ids, :name, :service, :data_store_location_ca, :cloud_type, :data, :encrypted_in_flight, :encrypted_at_rest, :_destroy],
                                cyber_security_insurances_attributes: [:id, :file_ids, :company, :coverage, :coverage_amount, :date_of_expiry, :_destroy],
                                activity_time_log_attributes: [:id, :network_discovery, :network_discovery_never, :penetration_testing, :penetration_testing_never, :vulnerability_assessment, :vulnerability_assessment_never, :hardware_refresh, :hardware_refresh_never, :hardware_inventory, :hardware_inventory_never, :software_inventory, :software_inventory_never, :_destroy], 
                                shared_bank_informations_attributes: [:id, :name, :level_of_access, :purpose, :_destroy] 
                                
                              ],
    	technology_values_attributes: [:id, :platform_category, :platform_type, 
																		 :vendor, :platform, :version, :service_pack, 
																		 :supported, :_destroy, :new_value],
      history_submissions_attributes: [:id, :incident_type, :impact, :discovery_time, :source, 
                                       :data_loss, :incident_details, :_destroy]
		]
      
  end
end