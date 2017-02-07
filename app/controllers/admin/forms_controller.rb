class Admin::FormsController < Admin::BaseController
  include FormBehaviors

  def form_params
    form_attributes = [:id, :name]
    params.require(:form).permit(form_attributes + form_fields_attributes)
  end

  def index
    @q = Form.ransack(params[:q])
    @forms = @q.result(distinct: true).paginate(page: params[:page])
  end

  def edit
    @form = Form.find(params[:id])
  end

  def create
    @form = Form.new(form_params)
    if @form.save
      redirect_to edit_admin_form_path(@form)
    else
      flash[:error] = "error"
      redirect_to :back
    end
  end

  def update
    @form = Form.find(params[:id])
    if @form.update_attributes(form_params)
      redirect_to edit_admin_form_path(@form)
    else
      flash[:error] = "error"
      redirect_back fallback_location: admin_forms_path
    end
  end

  def new
    @form = Form.new
  end
end