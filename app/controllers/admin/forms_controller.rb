class FormsController < Admin::BaseController
  include FormBehaviors

  def program_params
    form_attributes = [:id, :name]
    params.require(:form).permit(form_attributes + form_fields_attributes)
  end


  def create
    binding.pry
  end

  def new
    binding.pry
  end
end