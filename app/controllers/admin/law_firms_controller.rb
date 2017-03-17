class Admin::LawFirmsController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Dashboard", :root_path

  def index
    @q = law_firms.ransack(params[:q])
    @law_firms = @q.result(distinct: true)
    add_breadcrumb "Law Firms", :admin_law_firms_path
  end

  def show
    @law_firm = LawFirm.find(params[:id])
    add_breadcrumb @law_firm.name, :admin_law_firm_path
  end

  def create
  	@law_firm = LawFirm.new(law_firms_params)
  	if @law_firm.save
      # Pass true as a 2nd arg if admin wants to send the activity as notification as well
      @law_firm.log_activity('account_created', true)

      @law_firm.user.send_reset_password_instructions

  		redirect_to :admin_law_firms
  	else
  		flash[:alert] = "There was an error creating the law firm"
  		render :new
  	end
  end

  def update
  	@law_firm = LawFirm.find(params[:id])
  	if @law_firm.update_attributes(law_firms_params)
  		redirect_to :admin_law_firms
  	else
  		flash[:alert] = "There was an error updating the law firm"
  		render :new
  	end
  end

  def new
  	@law_firm = LawFirm.new

    add_breadcrumb "Create Law Firm", :new_admin_law_firm_path 
  end

  def edit
  	@law_firm = LawFirm.find(params[:id])

    add_breadcrumb "#{@law_firm.name}", :admin_law_firm_path 
  end

  def begin_certification_process
    @law_firm = LawFirm.find(params[:id])
    FormSubmission.generate_initial_submissions(@law_firm)
    redirect_to :admin_law_firms
  end

  def begin_recertification_process
    @law_firm = LawFirm.find(params[:id])
    last_form_submission = @law_firm.form_submissions.latest

    # TODO: Check if we want to copy the notes and follow ups of the old form submission
    new_form_submission = last_form_submission.amoeba_dup
    new_form_submission.status = 'sent'

    if new_form_submission.save
      @law_firm.log_activity('recertification_process_initiated', true)
      redirect_to :admin_law_firms
    end
  end

  def decertify
    @law_firm = LawFirm.find_by(id: params[:id])
    @law_firm.user.update_attributes(deactivated_at: Time.now)

    form_submission = @law_firm.form_submissions.latest
    form_submission.status = 'decertified'
    form_submission.reason = params[:reason]

    if form_submission.save!
      @law_firm.log_activity('decertified', true)
      head :ok
    end
  end

  def add_internal_note
    @law_firm = LawFirm.find_by(id: params[:id])
    internal_note = @law_firm.add_internal_note(params[:message], current_admin_admin_user)
    render partial: 'internal_note', locals: {note: internal_note}
  end

  def law_firms
    case params[:filter]
    when 'certified'
      LawFirm.joins(:form_submissions).where("form_submissions.created_at = (SELECT MAX(form_submissions.created_at) FROM form_submissions WHERE form_submissions.law_firm_id = law_firms.id) AND form_submissions.status='approved'")
    when 'under_process'
      LawFirm.joins(:form_submissions).where("form_submissions.created_at = (SELECT MAX(form_submissions.created_at) FROM form_submissions WHERE form_submissions.law_firm_id = law_firms.id) AND form_submissions.status='sent'")
    when 'decertified'
      LawFirm.joins(:form_submissions).where("form_submissions.created_at = (SELECT MAX(form_submissions.created_at) FROM form_submissions WHERE form_submissions.law_firm_id = law_firms.id) AND form_submissions.status='decertified'")
    else
      LawFirm
    end
  end

  private

  def law_firms_params
  	params.require(:law_firm).permit(:name, :description, :email, :phone, :temp_password)
  end

end
