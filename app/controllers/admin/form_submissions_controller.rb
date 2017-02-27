class Admin::FormSubmissionsController < Admin::BaseController
  include SubmissionBehaviors

  before_action :before_steps, only: [:policy_step, :process_step]
  before_action :before_non_dynamic_forms, only: [:technology_step, :history_step]

  helper_method :next_step_path, :current_step_path, :steps, :previous_step_path, :current_step, :wizard_path

  def before_steps
    @form_submission = FormSubmission.find(params[:id])
    @form = @form_submission.send("form_#{current_step}")
  end

  def before_non_dynamic_forms
    @form_submission = FormSubmission.find(params[:id])
  end

  def new
    @form = Form.find(params[:form_id])
    @form_submission = FormSubmission.new(form: @form)
  end

  def policy_step
  end

  def process_step
  end

  def technology_step
  end

  def history_step
  end

  def edit
    redirect_to first_step_path
  end

  def update
    @form_submission = FormSubmission.find(params[:id])
    if @form_submission.update(form_submissions_params)
      render json: :ok
    else
      render :edit
    end
  end

  def create
    @form_submission = FormSubmission.new(form_submissions_params)
    if @form_submission.save
      redirect_to :back, notice: 'Form submitted'
    else
      @form = Form.find(params[:form_id])
      render :new
    end
  end
private
  def current_step
    step = params[:action].split("_").first.to_sym
    [:edit, :update].include?(step) ? request.referrer.split('/').last.split("_").first.to_sym : step
  end

  def steps
    [:policy, :process, :technology, :history]
  end

  def wizard_path(step)
    eval("#{step}_step_admin_form_submission_path")
  end

  def next_step_path
    wizard_path(next_step)
  end

  def first_step_path
    wizard_path(steps.first)
  end

  def current_step_path
    wizard_path(current_step)
  end

  def previous_step_path
    wizard_path(previous_step)
  end

  def next_step
    current_step_index = steps.find_index(current_step)
    current_step_index == (steps.count - 1) ? current_step : steps[current_step_index + 1]
  end

  def previous_step
    current_step_index = steps.find_index(current_step)
    current_step_index == 0 ? current_step : steps[current_step_index - 1]
  end
  
  def form_submissions_params
    form_submission_attributes = [:id, :form_id]
    params.require(:form_submission).permit(form_submission_attributes + form_values_attributes)
  end
end
