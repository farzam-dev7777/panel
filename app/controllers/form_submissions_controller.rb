require 'csv'
class FormSubmissionsController < BaseController
  include SubmissionBehaviors

  load_and_authorize_resource
  
  before_action :follow_ups, except: :index
  before_action :before_steps, only: [:conflicts_step, :pricing_step, :relationship_step, :diversity_step, :innovation_step, :resourcing_step, :lawfirm_step]
  before_action :before_non_dynamic_forms, only: [:technology_step, :history_step]

  before_action :prevent_resubmission, only: [:update, :submit_forms]

  helper_method :next_step_path, :current_step_path, :steps, :previous_step_path, 
                :current_step, :wizard_path, :last_step, :first_step, :logics, :follow_up_stats

  def prevent_resubmission
    form_submission = FormSubmission.find_by(id: params[:id])
    form_submission.decision_made? ? false : true
  end

  def show
   
    redirect_to technology_step_form_submission_path
  end

  def before_steps
    @form_submission = FormSubmission.find(params[:id])
    @form = @form_submission.send("form_#{current_step}")
  end

  def technology_step_bulk_upload
    if @form_submission
      if params[:upload_custom_file] == "true"
        rows = []
        invalid_rows = []
        CSV.foreach(params[:files][0].path, {:headers => true, :header_converters => :symbol}) do |row|
          ActiveRecord::Base.transaction do
            tech = Technology.find_or_create_by(row.to_h)
            row[:form_submission_id] = @form_submission.id
            row[:technology_id] = tech.id
            tech_value = TechnologyValue.find_or_initialize_by(row.to_h)
            if tech_value.save
              rows << tech_value 
            else
              invalid_rows << tech_value
            end
          end
        end
        render json: { message: "Imported successfully!", rows: rows, invalid_rows: invalid_rows, upload_custom_file: true }
      else
        fa = @form_submission.file_attachments.first || @form_submission.file_attachments.build
        fa.file = params[:files][0]
        if fa.save
          render json: { message: "Uploaded successfully!", upload_custom_file: false }
        else
          render json: { message: "Oops! something went wrong!" }, status: 422
        end
      end
    else
      render json: { message: "Can't find the form_submission" }, status: 422
    end
  end

  def before_non_dynamic_forms
    @form_submission = FormSubmission.find(params[:id])
  end

  def new
    @form = Form.find(params[:form_id])
    @form_submission = FormSubmission.new(form: @form)
  end

  def conflicts_step
    # @form_submission = FormSubmission.find(params[:id])
    # if(@form_submission.status == 'sent')
    #   @form_submission.status = 'started'
    #   @form_submission.save
    #   log = ActivityLog.find_by(loggable_id: @form_submission.id, loggable_type: 'FormSubmission', law_firm_id: current_law_firm.id)
    #   FormSubmission.log_activity('seal_certification_process_initiated', true, @form_submission, current_user) if @form_submission && !log
    # end
  end

  def pricing_step
    # @form_submission = FormSubmission.find(params[:id])
    # if(@form_submission.status == 'sent')
    #   @form_submission.status = 'started'
    #   @form_submission.save
    #   log = ActivityLog.find_by(loggable_id: @form_submission.id, loggable_type: 'FormSubmission', law_firm_id: current_law_firm.id)
    #   FormSubmission.log_activity('seal_certification_process_initiated', true, @form_submission, current_user) if @form_submission && !log
    # end
  end
  
  def relationship_step

  end

  def diversity_step

  end

  def innovation_step
  end

  def resourcing_step
  end

  def lawfirm_step
  end


  def technology_profile
  end

  def history_profile
  end

  # def process_step
  # end

  # def technology_step
  # end

  # def history_step
  # end

  def logics
    @logics ||= current_step == :pricing ? @form_submission.form.try(:all_logics) : @form_submission.send("form_#{current_step}").try(:all_logics)
  end

  def edit
    @readonly = true
    redirect_to first_step_path
  end

  def law_firm_update
    @law_firm = LawFirm.find(@form_submission.law_firm.id)
  	if @law_firm.update_attributes(law_firms_params)
  		@law_firm.update_attributes(profile_completed: true)
       
      @form_submission = FormSubmission.find(params[:id])
        @form_submission.submitted = true
        @form_submission.submitted_on = Time.now
        @form_submission.status = 'submitted'
        if (@form_submission.save)

          # Creates action items for the law firm that has just been approved
          generate_security_threats

          AdminMailer.forms_submitted(@form_submission).deliver_now
          FormSubmission.log_activity('information_security_policy_submitted', true, @form_submission, current_user)
        end
       
  		redirect_to root_url, notice: "RFI Submited"
  	else
  		redirect_to first_step_path
  	end
  end

  def update
    @form_submission = FormSubmission.find(params[:id])
    if @form_submission.update(form_submissions_params)
      @form_submission.last_submitted_by = current_user
      @form_submission.save
      @form_submission.touch
      if request.referrer.split('/').last.to_sym == :pricing_step
        FormSubmission.log_activity('technologies_updated', true, @form_submission, current_user)
      elsif request.referrer.split('/').last.to_sym == :history_profile
        FormSubmission.log_activity('history_updated', true, @form_submission, current_user)
      end
      redirect_to params[:redirect_value]
    # elsif form_submissions_params["technology_values_attributes"]
    #   @current_step = :technology
    #   flash.now[:alert] = 'Please fill all the fields to save'
    #   render :technology_step
    else
      # current_step = params[:redirect_value].split("/")
      # render current_step.last.to_sym
      redirect_to params[:redirect_value]
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

      # Creates action items for the law firm that has just been approved
      generate_security_threats

      AdminMailer.forms_submitted(@form_submission).deliver_now
      FormSubmission.log_activity('information_security_policy_submitted', true, @form_submission, current_user)
    end
    head :ok
  end

  def generate_security_threats
    action_items = 0
    technology_values = @form_submission.technology_values
    technology_values.each do |technology_value|
      security_threats = SecurityThreat.where(vendor: technology_value.vendor, platform: technology_value.platform, version: technology_value.version, service_pack: technology_value.service_pack)
      
      # Check if the threat already exists for the law firm
      action_items = current_law_firm.action_items.where(security_threat_id: security_threats.map(&:id)).count if security_threats.any?
      next unless action_items == 0

      security_threats.each do |threat|
        threat.generate_pending_action_items_after_approval(@form_submission.law_firm_id, AdminUser.first)
      end
    end
  end

  def follow_ups
    @form_submission = FormSubmission.find_by(id: params[:id])

    @follow_ups = case current_step
                  when :conflicts
                    @form_submission.follow_ups.conflicts.decorate
                  when :pricing
                    @form_submission.follow_ups.pricing.decorate
                  when :relationship
                    @form_submission.follow_ups.relationship.decorate
                  when :diversity
                    @form_submission.follow_ups.diversity.decorate
                  when :innovation
                    @form_submission.follow_ups.innovation.decorate
                  when :resourcing
                    @form_submission.follow_ups.resourcing.decorate
                  when :lawfirm
                    #@form_submission.follow_ups.lawfirm.decorate  
                  end
      
  end

  def follow_up_stats
    stats = {}
    @form_submission.follow_ups.review.map(&:loggable).each do |form_value|
      if form_value.try(:form_field).try(:formable)
        case form_value.form_field.formable.name
        when 'Conflicts'
          stats[:conflicts] = (stats[:conflicts] || 0) + 1
        when 'Pricing'
          stats[:pricing] = (stats[:pricing] || 0) + 1
        when 'Relationship'
          stats[:relationship] = (stats[:relationship] || 0) + 1
        when 'Diversity'
          stats[:diversity] = (stats[:diversity] || 0) + 1
        when 'Innovation'
          stats[:innovation] = (stats[:innovation] || 0) + 1
        when 'Resourcing'
          stats[:resourcing] = (stats[:resourcing] || 0) + 1
        when 'Lawfirm'
          stats[:lawfirm] = (stats[:lawfirm] || 0) + 1  
        end 
      else
        case form_value.class.to_s
        when 'TechnologyValue'
          stats[:technology] = (stats[:policy] || 0) + 1
        when 'HistorySubmission'
          stats[:history] = (stats[:process] || 0) + 1
        end 
      end
    end
    stats
  end

private

  def current_step
    step = params[:action].split("_").first.to_sym
    @current_step ||= [:edit, :update].include?(step) ? request.referrer.split('/').last.split("_").first.to_sym : step
  end

  def steps
    # , :lawfirm
    [:conflicts, :relationship, :innovation, :pricing, :diversity, :resourcing, :lawfirm]
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
    current_step_path.include? "lawfirm_step"
  end

  def first_step
    #current_step_path.include? "pricing_step"
    current_step_path.include? "conflicts_step"
  end
  
  def form_submissions_params
    form_submission_attributes = [:id, :form_id]
    params.require(:form_submission).permit(form_submission_attributes + form_values_attributes)
  end

  def law_firms_params
    params.require(:law_firm).permit(
      :name, :description, :email, :phone, :temp_password, 
      :relationship_manager_email, :law_firm_type, :principle_name,
      :principle_title, :principle_contact_info, :parent_company,
      :sister_firm, 
      :initial_date_of_engagement_with_the_bank,
      :number_of_lawyers,
      :secondary_rm_contact,
      :secondary_rm_contact_email,
      :billing_contact_name,
      :billing_contact_email,
      :information_security_contact,
      :information_security_contact_email,
      :diverse,
      :value_add_activities,
      :feedback,
      :issues,
      :merger_combination,
      :engagement_number,
      :relationship_number,
      :information_security_class,
      :information_security_assessment_outcome,
      :action_plan_findings,
      :action_plan_status,
      :bmo_relationship_partner_email,
      :bmo_relationship_partner_name,
      :bmo_relationship_partner_phone_number,
      :confidentiality_level_of_matters_that_are_handled,
      locations_attributes: [
        :id, :address1, :address2, :city, 
        :province, :postal_code, :country, :_destroy
      ], jurisdictions_attributes: [
        :id, :country, :_destroy, 
        city: []
      ], 
      practice_area: [], 
      type_of_matters_your_law_firm_handles_for_us: [],
      type_of_services_your_law_firm_provides_generally: []
    )
  end

end
