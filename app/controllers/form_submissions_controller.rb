class FormSubmissionsController < BaseController
  include SubmissionBehaviors

  load_and_authorize_resource
  
  before_action :follow_ups, except: :index
  before_action :before_steps, only: [:policy_step, :process_step]
  before_action :before_non_dynamic_forms, only: [:technology_step, :history_step]

  helper_method :next_step_path, :current_step_path, :steps, :previous_step_path, 
                :current_step, :wizard_path, :last_step, :first_step, :logics

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
    @form_submission = FormSubmission.find(params[:id])
    if(@form_submission.status == 'sent')
      @form_submission.status = 'started'
      @form_submission.save
      log = ActivityLog.find_by(loggable_id: @form_submission.id, loggable_type: 'FormSubmission', law_firm_id: current_law_firm.id)
      FormSubmission.log_activity('seal_certification_process_initiated', true, @form_submission, current_user) if @form_submission && !log
    end
  end

  def technology_profile
  end

  def history_profile
  end

  def process_step
  end

  def technology_step
  end

  def history_step
  end

  def logics
    @logics ||= current_step == :policy ? @form_submission.form.try(:all_logics) : @form_submission.form_process.try(:all_logics)
  end

  def edit
    @readonly = true
    redirect_to first_step_path
  end

  def update
    @form_submission = FormSubmission.find(params[:id])
    if @form_submission.update(form_submissions_params)
      if request.referrer.split('/').last.to_sym == :technology_profile
        FormSubmission.log_activity('technologies_updated', true, @form_submission, current_user)
      elsif request.referrer.split('/').last.to_sym == :history_profile
        FormSubmission.log_activity('history_updated', true, @form_submission, current_user)
      end
      render json: :ok
    else
      render :technology_step
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

  def submit_forms
    @form_submission = FormSubmission.find(params[:id])
    @form_submission.submitted = true
    @form_submission.submitted_on = Time.now
    @form_submission.status = 'submitted'
    if (@form_submission.save)
      AdminMailer.forms_submitted(@form_submission).deliver_now
      FormSubmission.log_activity('information_security_policy_submitted', true, @form_submission, current_user)
    end
    head :ok
  end

  def follow_ups
    @form_submission = FormSubmission.find_by(id: params[:id])

    @follow_ups = case current_step
                  when :policy
                    @form_submission.follow_ups.policy.decorate
                  when :process
                    @form_submission.follow_ups.policy.decorate
                  when :technology
                    @form_submission.follow_ups.technology.decorate
                  when :history
                    @form_submission.follow_ups.history.decorate
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
    begin
      eval("#{step}_step_form_submission_path")
    rescue => e
      Rollbar.log('error', e)
    end
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

  def last_step
    current_step_path.include? "history_step"
  end

  def first_step
    current_step_path.include? "policy_step"
  end
  
  def form_submissions_params
    form_submission_attributes = [:id, :form_id]
    params.require(:form_submission).permit(form_submission_attributes + form_values_attributes)
  end
end
