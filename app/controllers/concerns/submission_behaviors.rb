module SubmissionBehaviors
  extend ActiveSupport::Concern

  def form_values_attributes
    [
    	form_values_attributes: [:id, :form_field_id, :value, :submittable_id, :submittable_type, 
    													:form_field_label, :file_value, 
    													file_attachments_attributes: [:id, :file] ],
    	technology_values_attributes: [:id, :platform_category, :platform_type, 
																		 :vendor, :platform, :version, :service_pack, 
																		 :supported, :_destroy]												  
		]
      
  end
end