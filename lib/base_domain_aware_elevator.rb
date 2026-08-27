require 'tenant_host'

# Prepended onto Apartment::Elevators::Subdomain so that hosts under a
# configured base domain (see TenantHost) resolve the tenant correctly:
# the bare base domain switches to no tenant (public schema), and only a
# label prefixed to the base domain is treated as the tenant. All other
# hosts keep the elevator's stock subdomain parsing.
module BaseDomainAwareElevator
  def parse_tenant_name(request)
    host = request.host.to_s
    return TenantHost.tenant_for(host) if TenantHost.known?(host)

    super
  end
end
