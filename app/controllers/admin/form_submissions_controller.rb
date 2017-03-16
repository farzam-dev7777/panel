class Admin::FormSubmissionsController < Admin::BaseController

	layout false
  layout 'admin', :except => :show

  before_action :follow_ups, except: :index
  before_action :before_steps, only: [:policy_step, :process_step]
  before_action :before_non_dynamic_forms, only: [:technology_step, :history_step]

  helper_method :next_step_path, :current_step_path, :steps, :previous_step_path, 
                :current_step, :wizard_path, :last_step
  
  def index
  	@form_submissions = FormSubmission.all.decorate
  end

  def before_steps
    @form_submission = FormSubmission.find(params[:id])
    @form = @form_submission.send("form_#{current_step}")
  end

  def before_non_dynamic_forms
    @form_submission = FormSubmission.find(params[:id])
  end

  def policy_step
    @form_submission = FormSubmission.find(params[:id])
    log = ActivityLog.find_by(loggable_id: @form_submission.id, loggable_type: 'FormSubmission', law_firm_id: @form_submission.law_firm_id)
    
    FormSubmission.log_activity('information_security_policy_review_started', true, @form_submission) if @form_submission && !log
  end

  def process_step
  end

  def technology_step
  end

  def history_step
    total_score = 0
    score_counter = 0
    @form_submission = FormSubmission.find(params[:id])
    
    @form_submission.form_values.each do |form_value|
      if !form_value.value.blank? && form_value.form_field.scored
        total_score = total_score + form_value.form_field.score 
        score_counter = score_counter + 1
      end
    end
    @system_score = score_counter > 0 ? total_score/score_counter : 0
    @form_submission.update_attributes(system_score: @system_score)
  end

  def edit
    redirect_to first_step_path
  end

  def update
    @form_submission = FormSubmission.find(params[:id])
    if @form_submission.update(form_submissions_params)
      render json: :ok
    else
      render :technology_step
    end
  end

  def notes
    @form_submission = FormSubmission.find_by(id: params[:id])
    @notes = @form_submission.notes
  end

  def follow_ups
    @form_submission = FormSubmission.find_by(id: params[:id])

    @follow_ups = case current_step
                  when :policy
                    @form_submission.follow_ups.policy.decorate
                  when :process
                    @form_submission.follow_ups.process.decorate
                  when :technology
                    @form_submission.follow_ups.technology.decorate
                  when :history
                    @form_submission.follow_ups.history.decorate
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

  def update_score
    # return unless params[:form_submission][:score].present?
    @form_submission = FormSubmission.find_by(id: params[:id])
    @form_submission.score = params[:form_submission][:score]
    if @form_submission.save
      redirect_to :admin_law_firms
    else
      redirect_to :back
    end
  end

  def save_and_follow_up
    @form_submission = FormSubmission.find(params[:id])
    @form_submission.submitted = false
    @form_submission.submitted_on = nil
    @form_submission.follow_ups.pending.update_all(status: 'review')
    if (@form_submission.update_attributes(status: :follow_up))
      FormSubmission.log_activity('follow_up', true, @form_submission)
      redirect_to :admin_law_firms
    end
  end

  def mark_as_checked
    @field_value = params[:loggable_type].constantize.find_by(id: params[:loggable_id]) 
    @field_value.update_attributes(checked: !@field_value.checked) if @field_value

    render partial: 'check_mark', locals: {loggable: @field_value, form_type: params[:loggable_type]}, layout: false
  end

  def approve
    @form_submission = FormSubmission.find(params[:id])
    @form_submission.status = 'approved'
    if (@form_submission.save)
      FormSubmission.log_activity('approved', true, @form_submission)
      redirect_to :admin_law_firms
    end
  end

  def decline
    @form_submission = FormSubmission.find(params[:id])
    @form_submission.status = 'decline'
    if (@form_submission.save)
      FormSubmission.log_activity('declined', true, @form_submission)
      redirect_to :admin_law_firms
    end
  end

  def update_assessor_score
    @form_submission = FormSubmission.find(params[:id])
    @form_submission.assessor_score = params[:score]
    if(@form_submission.save)
      calculate_total_score
      render json: @form_submission
    end
  end

  def calculate_total_score
    if (@form_submission.assessor_score && @form_submission.system_score)
      @form_submission.update_attributes(total_score: (@form_submission.system_score + @form_submission.assessor_score)/2)
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

  def last_step
    current_step_path.include? "history_step"
  end
  
  def form_submissions_params
    form_submission_attributes = [:id, :form_id]
    params.require(:form_submission).permit(form_submission_attributes + form_values_attributes)
  end

end