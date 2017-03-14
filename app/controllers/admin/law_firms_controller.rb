class Admin::LawFirmsController < Admin::BaseController

  layout 'admin'

  def index
  	@q = LawFirm.ransack(params[:q])
    @law_firms = @q.result(distinct: true).paginate(page: params[:page])
  end

  def show
    @law_firm = LawFirm.find(params[:id])
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
  end

  def edit
  	@law_firm = LawFirm.find(params[:id])
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

  private

  def law_firms_params
  	params.require(:law_firm).permit(:name, :description, :email, :phone, :temp_password)
  end

end
