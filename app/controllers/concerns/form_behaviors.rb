module FormBehaviors
  extend ActiveSupport::Concern

  def form_fields_attributes
    [form_fields_attributes: 
    	[
    		:id, :label, :max, :min, :required, :type, :parent_id, :show_when_form_field_id, :custom_logic, :show_when_form_field_value, :score, :scored, :_destroy, :position, :group_form_id, :repeater, 
    		dropdown_options_attributes: [:id, :key, :value, :score, :_destroy], 
    		logics_attributes: [:change_field_id, :listen_field_id, :perform_action, :logic_to_be_applied, :values, :_destroy] ]]
  end
end
