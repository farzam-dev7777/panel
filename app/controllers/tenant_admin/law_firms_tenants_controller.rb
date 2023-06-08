class TenantAdmin::LawFirmsTenantsController < TenantAdmin::BaseController
  layout 'tenant_admin'

  def destroy
    @tenant_law_firm = LawFirmsTenant.find_by(id: params[:id])
    tenant_id = @tenant_law_firm&.tenant_id
    authorize! :destroy, @tenant_law_firm
    if @tenant_law_firm.destroy
      message = "Law firm de-linked from tenant successfully."
      redirect_to tenant_admin_tenant_path(id: tenant_id), notice: message
    else
      message = "There was an error delinking the law firm, errors: #{@tenant_law_firm&.errors&.full_messages&.join(', ')}"
      redirect_to tenant_admin_tenant_path(id: tenant_id), alert: message
    end
  end

end