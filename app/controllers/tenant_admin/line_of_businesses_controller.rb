class TenantAdmin::LineOfBusinessesController < TenantAdmin::BaseController
  layout 'tenant_admin'


  def index
    @line_of_business = LineOfBusiness.all
  end

  def new
    @line_of_business = LineOfBusiness.new
  end

  def edit
    @line_of_business = LineOfBusiness.find_by(id: params[:id])
  end

  def create
    @line_of_business = LineOfBusiness.new(line_of_business_params)
    authorize! :create, @line_of_business
    if @line_of_business.save
      # @line_of_business.users = User.where(id: params[:lob_sso][:user_ids])
      flash[:notice] = "Lob created successfully"
      redirect_to tenant_admin_line_of_businesses_path
    else
      flash[:alert] = "There was an error creating new tanant admin user. Errors: #{@user&.errors&.full_messages&.join(', ')}"
      render :new
    end
  end

  def update
    @line_of_business = LineOfBusiness.find_by(id: params[:id])
    if @line_of_business.update(line_of_business_params)
      # @line_of_business.users = User.where(id: params[:lob_sso][:user_ids])
      flash[:notice] = "Lob updated successfully."
      redirect_to tenant_admin_line_of_businesses_path
    else
      flash.now[:alert] = "There was an error updating the user, errors: #{@user&.errors&.full_messages&.join(', ')}"
  		render :new
    end
  end

  def destroy
    @line_of_business = LineOfBusiness.find_by(id: params[:id])
    if @line_of_business.destroy
      flash[:notice] = "Lob deleted successfully."
      redirect_to tenant_admin_line_of_businesses_path
    else
      flash.now[:alert] = "There was an error deleting the user, errors: #{@user&.errors&.full_messages&.join(', ')}"
      redirect_to edit_tenant_admin_line_of_business_path(@user)
    end
  end

  private

  def line_of_business_params
    params.require(:line_of_business).permit(
      :name, :sso_group, :email, :tenant_id, user_ids: []
    )
  end

end