module FormBehaviors
  extend ActiveSupport::Concern

  def form_fields_attributes
    [form_fields_attributes: [:id, :label, :max, :min, :required, :type, :parent_id, :_destroy, :position, dropdown_options_attributes: [:id, :key, :value, :_destroy]]]
  end
end
