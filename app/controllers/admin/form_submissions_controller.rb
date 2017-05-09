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
    
    FormSubmission.log_activity('information_security_policy_review_started', true, @form_submission, current_admin_user) if @form_submission && !log
  end

  def process_step
  end

  def technology_step
    @security_threats = SecurityThreat.all
  end

  def history_step
    total_score = 0
    score_counter = 0
    @form_submission = FormSubmission.find(params[:id])
    
    @form_submission.form_values.each do |form_value|
      if !form_value.value.blank?
        if form_value.is_a_repeater_field?
          total_score = total_score + calculate_repeater_field_score(form_value)
        else
          total_score = total_score + form_value.try(:form_field).try(:score) if form_value.try(:form_field).try(:score) 
        end
        score_counter = score_counter + 1
      end
    end
    @system_score = score_counter > 0 ? (total_score/score_counter).round(2) : 0
    @form_submission.update_attributes(system_score: @system_score)
  end

  def calculate_repeater_field_score(form_value)
    repeater_field_score = []
    calculated_score = 0
    case form_value.form_field.type
    when 'InformationSecurityPolicyField'
      calculated_score = compute_field_score(form_value, repeater_field_score, 'InformationSecurityPolicy', 'information_security_policies')
    when 'CyberSecurityStandardField'
      calculated_score = compute_field_score(form_value, repeater_field_score, 'CyberSecurityStandardField', 'cyber_security_standards')
    when 'ThirdPartyVendorField'
      calculated_score = compute_field_score(form_value, repeater_field_score, 'ThirdPartyVendor', 'third_party_vendors')
    when 'CloudProviderField'
      calculated_score = compute_field_score(form_value, repeater_field_score, 'CloudProvider', 'cloud_providers')
    when 'CyberSecurityInsuranceField'
      calculated_score = compute_field_score(form_value, repeater_field_score, 'CyberSecurityInsurance', 'cyber_security_insurances')
    end
    calculated_score
  end

  def compute_field_score(form_value, repeater_field_score, model, association)
    ignored_columns = ["id", "created_at", "updated_at", "form_value_id"]
    single_field_score = 5
    columns = model.constantize.column_names
    form_value.send(association).each do |field|
      columns.each_with_index do |column_name, index|
        single_field_score = single_field_score - 1 if field[column_name.to_sym].blank? && !ignored_columns.include?(column_name)
        repeater_field_score.push(single_field_score) && single_field_score = 5 if columns.size - 1 == index
      end
    end
    ((repeater_field_score.sum / ((columns - ignored_columns).size * 5).to_f) * 5).round(2)
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

    if(@form_submission.check_follow_ups)
      @form_submission.submitted = false
      @form_submission.submitted_on = nil
      @form_submission.follow_ups.pending.update_all(status: 'review')
      if (@form_submission.update_attributes(status: :follow_up))
        LawFirmMailer.decision_reached(@form_submission, 'Follow Up').deliver_now
        FormSubmission.log_activity('follow_up', true, @form_submission, current_admin_user)
        redirect_to :admin_law_firms
      end
    else
      redirect_to history_step_admin_form_submission_path(@form_submission), alert: "You haven't added any follow up notes." 
    end
  end

  def mark_as_checked
    @field_value = params[:loggable_type].constantize.find_by(id: params[:loggable_id])
    @field_value.update_attributes(checked: !@field_value.checked) if @field_value

    render partial: 'check_mark', locals: {loggable: @field_value, form_type: params[:loggable_type]}, layout: false
  end

  def approve
    @form_submission = FormSubmission.find(params[:id])

    if @form_submission.system_score >= SystemSetting.score_threshold

      @form_submission.status = 'approved'

      # The admin will be notified after an year about the law firm.
      # Admin can review the law firm and take necessary action.
      @form_submission.expiry_date = Time.now + 1.year

      # Creates action items for the law firm that has just been approved
      # generate_security_threats

      if (@form_submission.save)
        LawFirmMailer.decision_reached(@form_submission, 'Approved').deliver_now
        FormSubmission.log_activity('approved', true, @form_submission, current_admin_user)
        redirect_to :admin_law_firms
      end
    else
      redirect_to history_step_admin_form_submission_path(@form_submission), alert: "The score (#{@form_submission.system_score}) is below system's threshold (#{SystemSetting.score_threshold}). You cannot approve the law firm" 
    end
  end

  def decline
    @form_submission = FormSubmission.find(params[:id])
    @form_submission.status = 'decline'
    if (@form_submission.save)
      LawFirmMailer.decision_reached(@form_submission, 'Declined').deliver_now
      FormSubmission.log_activity('declined', true, @form_submission, current_admin_user)
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

  def set_expiry_date
    @form_submission = FormSubmission.find_by(id: params[:id])

    current_expiry_date = @form_submission.expiry_date

    if @form_submission && params[:expiry_date]
      @form_submission.update_attributes(expiry_date: Date.parse(params[:expiry_date]))
      custom_activity_message = "Expiry date changed from #{DateField.stringify_date(current_expiry_date)} to #{params[:expiry_date]}"
      FormSubmission.log_activity('expiry_date_changed', false, @form_submission, current_admin_user, custom_activity_message)
    end
    head :ok
  end

  def generate_security_threats
    technology_values = @form_submission.technology_values
    technology_values.each do |technology_value|
      security_threats = SecurityThreat.where(vendor: technology_value.vendor, platform: technology_value.platform, version: technology_value.version, service_pack: technology_value.service_pack)
      security_threats.each do |threat|
        threat.generate_pending_action_items_after_approval(@form_submission.law_firm_id, current_user)
      end
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