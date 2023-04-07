class TenantsController < BaseController

  # For Ajax only
  def switch
    begin
      Apartment::Tenant.switch!(params[:subdomain])
      render json: { success: true }
    rescue Apartment::TenantNotFound
      render json: { success: false, error: "Invalid Tenant" }
    end
  end

end