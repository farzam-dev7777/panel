class ExternalLawyersController < BaseController

  def index
    @law_firm  = LawFirm.find_by(id: params[:law_firm_id])
    @external_laywers = @law_firm.external_lawyers
  end

  def create
    @external_lawyer = ExternalLawyer.new(build_params)
    if @external_lawyer.save
      flash[:notice] = "External Lawyer created"
      redirect_to law_firm_external_lawyers_path(@external_lawyer.law_firm)
    else
      flash[:alert] = "There was an error initiating external lawyer request. #{@external_lawyer.errors.full_messages.join(', ')}" 
      render :new
    end
  end

  def new
    @law_firm  =LawFirm.find_by(id: params[:law_firm_id])
  	@external_lawyer = ExternalLawyer.new(law_firm_id: @law_firm.id)
  end

  def edit
    @law_firm  = LawFirm.find_by(id: params[:law_firm_id])
    @external_lawyer = ExternalLawyer.find(params[:id])
  end

  def update
    @external_lawyer = ExternalLawyer.find(params[:id])
    if @external_lawyer.update_attributes(build_params)
      flash[:notice] = "External Lawyer updated"
      redirect_to law_firm_external_lawyers_path(@external_lawyer.law_firm)
    else
      render :edit
    end
  end

  private

  def build_params
    params.require(:external_lawyer).permit(:id, :name, :law_firm_id)
  end

end
