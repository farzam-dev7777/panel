class TenantsController < BaseController

  # For Ajax only
  def switch
    tenant = Tenant.find_by(subdomain: params[:subdomain])
    if tenant.present?
      begin
        Apartment::Tenant.switch!(params[:subdomain])
        if Rails.env.development?
          url = "http://#{tenant&.subdomain}.lvh.me:3000"
        else
          url = "https://#{tenant&.subdomain}.#{ENV['DOMAIN_NAME']}"
        end
        render json: { success: true, url: url }
      rescue Apartment::TenantNotFound
        render json: { success: false, error: "Invalid Tenant" }
      end
    else
      render json: { success: false, error: "Invalid Tenant" }
    end
  end

end