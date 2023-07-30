class TenantAdmin::LawFirmsController < TenantAdmin::BaseController
  layout 'tenant_admin'

  load_and_authorize_resource :class => "LawFirm"

  def index
    @q = LawFirm.ransack(params[:q])
    @law_firms = @q.result.order('created_at DESC')
  end

  def new
    @law_firm = LawFirm.new
  end

  def edit
    @law_firms = LawFirm.find_by(id: params[:id])
  end

  def create
    @law_firm = LawFirm.new(tenant_admin_law_firm_params)
    if @law_firm.save
      flash[:notice] = "Law Firm created successfully"
      redirect_to tenant_admin_law_firms_path
    else
      flash[:alert] = "There was an error creating new law firm. Errors: #{@law_firm&.errors&.full_messages&.join(', ')}"
      render :new
    end
  end

  def update
    @law_firm = LawFirm.find_by(id: params[:id])
    if @law_firm.update(tenant_admin_law_firm_params)
      flash[:notice] = "Law Firm updated successfully."
      redirect_to tenant_admin_law_firms_path
    else
      flash.now[:alert] = "There was an error updating the law firm, errors: #{@law_firm&.errors&.full_messages&.join(', ')}"
  		render :new
    end
  end

  def destroy
    @law_firm = LawFirm.find_by(id: params[:id])
    if @law_firm.destroy
      flash[:notice] = "Law Firm deleted successfully."
      redirect_to tenant_admin_law_firms_path
    else
      flash.now[:alert] = "There was an error deleting the law firm, errors: #{@law_firm&.errors&.full_messages&.join(', ')}"
      redirect_to edit_tenant_admin_law_firm_path(@law_firm)
    end
  end

  private

  def tenant_admin_law_firm_params
    params.require(:law_firm).permit(
      :name
    )
  end

end