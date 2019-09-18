class Admin::FormSubmissionsController < Admin::BaseController

	layout false
  layout 'admin', :except => :show

  before_action :follow_ups, except: :index
  before_action :before_steps, only: [:pricing_step, :relationship_step, :diversity_step, :innovation_step, :resourcing_step]
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

  def pricing_step
    @form_submission = FormSubmission.find(params[:id])
    log = ActivityLog.find_by(loggable_id: @form_submission.id, loggable_type: 'FormSubmission', law_firm_id: @form_submission.law_firm_id)
    
    FormSubmission.log_activity('information_security_policy_review_started', true, @form_submission, current_admin_user) if @form_submission && !log
  end

  def relationship_step
  end

  def diversity_step
  end

  def innovation_step
  end

  def resourcing_step
  end

  def download_submission_pdf
    @form_submission = FormSubmission.find(params[:id])
    
    pdf = WickedPdf.new.pdf_from_string(
      render_to_string("admin/pdf/submission_body.html.erb", layout: "pdf.html.erb"),
      locals: {:form_submission => @form_submission},
      header: {
        content: render_to_string("admin/pdf/submission_header.html.erb", layout: "pdf.html.erb")
      },
      footer: {
        content: render_to_string("admin/pdf/submission_footer.html.erb", layout: "pdf.html.erb")
      }
     )

    # send file for download
    send_data pdf, :filename => "#{@form_submission.law_firm.users.first.try(:username)}_form_submission_#{Time.now}.pdf", :type => "application/pdf", :disposition => "attachment"
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
    @scores_debug = []
    
    @form_submission.form_values.each do |form_value|
      form_field_type = form_value.try(:form_field).try(:type)
      if form_field_type == "ActivityTimeLogField"
        score = 0.0
        field_scores = []
        fields = ["network_discovery", "penetration_testing", "vulnerability_assessment", "hardware_refresh", "hardware_inventory", "software_inventory"]
        fields.each do |field_name|
          date = form_value.activity_time_log.send(field_name)
          never_field = form_value.activity_time_log.send("#{field_name}_never")
          if date.present? && never_field != true
            field_scores << score_datefield(date)
          else
            field_scores << 0.0
          end
        end
        score = (field_scores.sum / fields.size)
        total_score += score
      elsif form_value.is_a_repeater_field?
        score = calculate_repeater_field_score(form_value)
        total_score = total_score + score
      elsif form_field_type == "MultiSelectField"
        scores = form_value.form_field.dropdown_options.where(value: form_value.multi_select_value).map(&:score)
        score = (scores.size > 0 ? (scores.sum / scores.size) : 0.0)
        total_score = total_score + score
      elsif form_field_type == "DropdownField"
        score = form_value.form_field.dropdown_options.find_by(value: form_value.value)&.score || 0.0
        total_score = total_score + score
      elsif form_field_type == "UploadField"
        score = form_value.file_attachments.blank? ? 0.0 : (form_value.form_field.score || 0.0)
        total_score = total_score + score
      elsif form_field_type == "DateField"
        # - Date is within last 12 months - score: 5
        # - Date is more than 12 months old - score: 2.5
        # - if blank: 0
        score = 0.0
        if !form_value.value.blank?
          begin
            date = Date.parse(form_value.value)
            score = score_datefield(date)
          rescue Exception => e
            score = 0.0
          end
        else
          score = 0.0
        end
        total_score = total_score + score
      elsif !form_value.value.blank?
        score = form_value.try(:form_field).try(:score) || 0.0
        total_score = total_score + score
      else
        score = 0.0
      end
      @scores_debug.push(
        form_field_type: form_field_type,
        score: score,
        total_score: total_score,
        score_counter: score_counter + 1,
        field_label: form_value.try(:form_field).try(:label)
      )
      score_counter = score_counter + 1
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
      calculated_score = compute_field_score(form_value, repeater_field_score, 'CyberSecurityStandard', 'cyber_security_standards')
    when 'ThirdPartyVendorField'
      calculated_score = compute_field_score(form_value, repeater_field_score, 'ThirdPartyVendor', 'third_party_vendors')
    when 'CloudProviderField'
      calculated_score = compute_field_score(form_value, repeater_field_score, 'CloudProvider', 'cloud_providers')
    when 'CyberSecurityInsuranceField'
      calculated_score = compute_field_score(form_value, repeater_field_score, 'CyberSecurityInsurance', 'cyber_security_insurances')
    when 'SharedBankInformationField'
      calculated_score = compute_field_score(form_value, repeater_field_score, 'SharedBankInformation', 'shared_bank_informations')
    end
    calculated_score
  end

  def compute_field_score(form_value, repeater_field_score, model, association)
    ignored_columns = ["id", "created_at", "updated_at", "form_value_id", "freq_of_review", "independent_review", "rank", "date_of_certification", "renewal", "coverage_amount", "policy", "standing", "data", "cloud_type"]
    ignored_columns = ignored_columns - ['policy'] if model == 'InformationSecurityPolicy'
    single_field_score = form_value.form_field.score ? form_value.form_field.score : 0.0
    columns = form_value.send(association).klass.columns.map(&:name)
    effective_columns = (columns - ignored_columns)
    effective_rows = total_rows = form_value.send(association).select{|row| row.id }
    effective_rows.each do |field|
      case model
      when 'CloudProvider'
        row_score = 0
        row_score += 1.0 if field.data_store_location_ca && ['United States', 'Canada'].include?(field.data_store_location_ca)
        row_score += 2.0 if field.encrypted_in_flight == 'Yes'
        row_score += 2.0 if field.encrypted_at_rest == 'Yes'
        repeater_field_score.push(row_score)
      when 'InformationSecurityPolicy'
        row_score = 0
        row_score += 1.0 if !field.policy.blank?
        row_score += 1.0 if !field.last_reviewed.blank?
        row_score += 1.0 if !field.last_updated.blank?
        row_score += 1.0 if !field.communication_status.blank?
        row_score += 1.0 if !field.file_attachments.blank?
        repeater_field_score.push(row_score)
      when 'CyberSecurityStandard'
        ## TBD:
        # standard -> anything other than NA and status is certified then the user get 5 score
        # standard -> anything other than NA and status -> "Anything other than certified then the user get 2.5 score
        row_score = 0
        row_score += 5.0 if field.standard && field.standard != "NA" && field.status == 'Certified'
        row_score += 2.5 if field.standard && field.standard != "NA" && field.status != 'Follow but not Certified'
        repeater_field_score.push(row_score)
      when 'SharedBankInformation'
        ## TBD: remove score as the user add more rows to this,
        row_score = (effective_rows.count >= 5) ? 0.0 : (5.0 - effective_rows.count)
        repeater_field_score.push(row_score)
      when 'CyberSecurityInsurance'
        ## TBD: 
        ## date of expiry > year - 5 score
        ## date of expiry > today - between today and +6 months - 1 score
        ## date of expiry between +6 months and +12 months - 2.5 score
        ## date of expiry < today - 0 score

        ## coverage >= 10M - 5 score
        ## coverage < 10M - 2.5 score

        expiry_score = 0.0
        coverage_score = 0.0

        if field.date_of_expiry
          expiry_score = score_cyber_security_datefield(field.date_of_expiry)
        end

        if field.coverage
          coverage_amount = field.coverage.to_f
          if coverage_amount >= 10_000_000
            coverage_score = 5.0
          elsif coverage_score < 10_000_000
            coverage_score = 2.5
          else
            coverage_score = 0.0
          end
        end
        
        row_score = (expiry_score + coverage_score) / 2
        repeater_field_score.push(row_score)
      else
        effective_columns.each_with_index do |column_name, index|
          if !field.send(column_name.to_sym).blank?
            repeater_field_score.push(1.0)
          end
        end
      end
    end
    total_possible_score = effective_rows.size * effective_columns.size
    (total_possible_score.to_f > 0.0) ? ((repeater_field_score.sum / total_possible_score.to_f) * single_field_score) : 0.0
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
                    when :pricing
                      @form_submission.follow_ups.policy.decorate
                    when :relationship
                      @form_submission.follow_ups.relationship.decorate
                    when :diversity
                      @form_submission.follow_ups.diversity.decorate
                    when :innovation
                      @form_submission.follow_ups.innovation.decorate
                    when :resourcing
                      @form_submission.follow_ups.resourcing.decorate
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
        # LawFirmMailer.decision_reached(@form_submission, 'Follow Up').deliver_now
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

    if @form_submission.follow_ups.map(&:status).include?('pending')
      redirect_to :back, alert: "Follow ups are pending!" 
    else
      # @form_submission = FormSubmission.find(params[:id])

      if @form_submission.system_score >= SystemSetting.score_threshold

        @form_submission.status = 'approved'

        # The admin will be notified after an year about the law firm.
        # Admin can review the law firm and take necessary action.
        @form_submission.expiry_date = Time.now + 1.year
        @form_submission.approved_at = Time.now

        # Creates action items for the law firm that has just been approved
        # generate_security_threats

        if (@form_submission.save)
          # LawFirmMailer.decision_reached(@form_submission, 'Approved').deliver_now
          # FormSubmission.log_activity('approved', true, @form_submission, current_admin_user)
          redirect_to :admin_law_firms
        end
      else
        redirect_to history_step_admin_form_submission_path(@form_submission), alert: "The score (#{@form_submission.system_score}) is below system's threshold (#{SystemSetting.score_threshold}). You cannot approve the law firm" 
      end
      
    end

  end

  def decline
    @form_submission = FormSubmission.find(params[:id])
    @form_submission.status = 'decline'
    if (@form_submission.save)
      # LawFirmMailer.decision_reached(@form_submission, 'Declined').deliver_now
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
    [:pricing, :relationship, :diversity, :innovation, :resourcing]
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

  def score_cyber_security_datefield(date)
    difference_in_days = (date - Date.today).to_i
    if difference_in_days >= 365
      score = 5.0
    elsif difference_in_days > 182 && difference_in_days < 365
      score = 2.5
    elsif difference_in_days >= 0 && difference_in_days <= 182
      score = 1.0
    else
      score = 0.0
    end
    score
  end

  def score_datefield(date)
    difference_in_days = (Date.today - date).to_i
    if difference_in_days >= 0 && difference_in_days <= 365
      score = 5.0
    elsif difference_in_days > 365
      score = 2.5
    else
      score = 0.0
    end
    score
  end

end