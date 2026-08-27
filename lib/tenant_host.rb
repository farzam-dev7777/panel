# Resolves tenant subdomains against configured base/application domains.
#
# Some hosting environments (e.g. Cloud 66) assign multi-label hostnames such
# as clownfish.panel-staging-05a8.staging.c66.me. Those hostnames are the
# application's base domain, not a tenant subdomain. TENANT_BASE_DOMAINS is a
# comma-separated list of such base domains, e.g.
#
#   staging:    TENANT_BASE_DOMAINS=clownfish.panel-staging-05a8.staging.c66.me
#   production: TENANT_BASE_DOMAINS=prawn.panel-prod-9514.c66.me
#
# For a host matching a configured base domain:
#   clownfish.panel-staging-05a8.staging.c66.me      -> tenant: none
#   abc.clownfish.panel-staging-05a8.staging.c66.me  -> tenant: "abc"
#
# Hosts that do not match any configured base domain (custom domains such as
# abc.example.com) are not handled here; callers fall back to the existing
# subdomain parsing so custom-domain behaviour is unchanged.
module TenantHost
  class << self
    def base_domains
      @base_domains ||= ENV.fetch('TENANT_BASE_DOMAINS', '')
                           .split(',')
                           .map { |domain| normalize(domain) }
                           .reject(&:empty?)
    end

    # Clears the memoized configuration (used by tests).
    def reset!
      @base_domains = nil
    end

    # True when the host is, or is a subdomain of, a configured base domain.
    def known?(host)
      !base_domain_for(host).nil?
    end

    def base_domain_for(host)
      host = normalize(host)
      base_domains.find { |base| host == base || host.end_with?(".#{base}") }
    end

    # "abc.BASE" -> "abc"; "BASE" -> nil; host not under a base domain -> nil
    def tenant_for(host)
      host = normalize(host)
      base = base_domain_for(host)
      return nil unless base

      prefix = host.delete_suffix(base).chomp('.')
      prefix.empty? ? nil : prefix
    end

    # Full host for a tenant subdomain relative to the request's base domain,
    # e.g. host_for("abc", "clownfish...c66.me") -> "abc.clownfish...c66.me".
    # Returns nil when the request host is not under a configured base domain;
    # callers fall back to Rails' subdomain: URL option.
    def host_for(subdomain, request_host)
      base = base_domain_for(request_host)
      return nil unless base

      subdomain.to_s.empty? ? base : "#{subdomain}.#{base}"
    end

    private

    def normalize(host)
      host.to_s.split(':').first.to_s.strip.downcase.chomp('.')
    end
  end
end
