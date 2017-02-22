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
  		redirect_to admin_law_firms_path, notice: "The law firm was created successfully"
  	else
  		flash[:alert] = "There was an error creating the law firm"
  		render :new
  	end
  end

  def update
  	@law_firm = LawFirm.find(params[:id])
  	if @law_firm.update_attributes(law_firms_params)
  		redirect_to admin_law_firms_path, notice: "The law firm was updated successfully"
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

  private

  def law_firms_params
  	params.require(:law_firm).permit(:name, :description, :email, :phone, :temp_password)
  end

end
