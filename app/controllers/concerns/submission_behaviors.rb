module SubmissionBehaviors
  extend ActiveSupport::Concern

  def form_values_attributes
    [
    	form_values_attributes: [:id, :form_field_id, :value, :submittable_id, :submittable_type, 
    													:form_field_label, :file_value, 
    													file_attachments_attributes: [:id, :file], 
                              vendors_attributes: [:id, :name, :vendor_type, :application, :_destroy],
                              cyber_security_standards_attributes: [:id, :rank, :standard, :date_of_certification, :renewal, :_destroy] ],
    	technology_values_attributes: [:id, :platform_category, :platform_type, 
																		 :vendor, :platform, :version, :service_pack, 
																		 :supported, :_destroy, :new_value],
      history_submissions_attributes: [:id, :incident_type, :impact, :discovery_time, :source, 
                                       :data_loss, :incident_details, :_destroy]     									  
		]
      
  end
end