class Admin::FormsController < Admin::BaseController
  include FormBehaviors

  def program_params
    form_attributes = [:id, :name]
    params.require(:form).permit(form_attributes + form_fields_attributes)
  end


  def create
    binding.pry
  end

  def new
    @form = Form.new
    fields = []
    dropdown_field = DropdownField.new(label: 'Gender')
    dropdown_field.options << {"Male" => "male"}
    dropdown_field.options << {"Female" => "female"}
    fields << dropdown_field
    fields << DateField.new(label: 'Date of Birth', min: '1910-10-10', max: '1910-10-10')
    @form.form_fields = fields
  end
end