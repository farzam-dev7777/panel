# Standalone unit test: runs with plain `ruby test/lib/tenant_host_test.rb`
# (TenantHost is pure Ruby) and also under `rails test`.
require 'minitest/autorun'
require_relative '../../lib/tenant_host'

class TenantHostTest < Minitest::Test
  STAGING_BASE = 'clownfish.panel-staging-05a8.staging.c66.me'.freeze
  PRODUCTION_BASE = 'prawn.panel-prod-9514.c66.me'.freeze

  def setup
    @original = ENV['TENANT_BASE_DOMAINS']
    TenantHost.reset!
  end

  def teardown
    ENV['TENANT_BASE_DOMAINS'] = @original
    TenantHost.reset!
  end

  def configure(domains)
    ENV['TENANT_BASE_DOMAINS'] = domains
    TenantHost.reset!
  end

  # --- Staging ---

  def test_staging_base_domain_has_no_tenant
    configure(STAGING_BASE)
    assert_nil TenantHost.tenant_for(STAGING_BASE)
    assert TenantHost.known?(STAGING_BASE)
  end

  def test_staging_abc_tenant
    configure(STAGING_BASE)
    assert_equal 'abc', TenantHost.tenant_for("abc.#{STAGING_BASE}")
  end

  def test_staging_xyz_tenant
    configure(STAGING_BASE)
    assert_equal 'xyz', TenantHost.tenant_for("xyz.#{STAGING_BASE}")
  end

  # --- Production ---

  def test_production_base_domain_has_no_tenant
    configure(PRODUCTION_BASE)
    assert_nil TenantHost.tenant_for(PRODUCTION_BASE)
    assert TenantHost.known?(PRODUCTION_BASE)
  end

  def test_production_abc_tenant
    configure(PRODUCTION_BASE)
    assert_equal 'abc', TenantHost.tenant_for("abc.#{PRODUCTION_BASE}")
  end

  def test_production_xyz_tenant
    configure(PRODUCTION_BASE)
    assert_equal 'xyz', TenantHost.tenant_for("xyz.#{PRODUCTION_BASE}")
  end

  # --- Custom domains fall back to legacy parsing (not handled here) ---

  def test_custom_domain_is_not_known
    configure(STAGING_BASE)
    refute TenantHost.known?('abc.example.com')
    assert_nil TenantHost.tenant_for('abc.example.com')
    assert_nil TenantHost.host_for('abc', 'abc.example.com')
  end

  def test_no_configuration_means_nothing_is_known
    configure('')
    refute TenantHost.known?(STAGING_BASE)
    assert_nil TenantHost.tenant_for("abc.#{STAGING_BASE}")
  end

  # --- Guards against false matches ---

  def test_partial_label_does_not_match_base_domain
    configure(STAGING_BASE)
    refute TenantHost.known?("evil-#{STAGING_BASE}")
    assert_nil TenantHost.tenant_for("notclownfish.panel-staging-05a8.staging.c66.me".sub('notclownfish', "not#{STAGING_BASE.split('.').first}"))
  end

  def test_multiple_base_domains
    configure("#{STAGING_BASE}, #{PRODUCTION_BASE}")
    assert_equal 'abc', TenantHost.tenant_for("abc.#{STAGING_BASE}")
    assert_equal 'abc', TenantHost.tenant_for("abc.#{PRODUCTION_BASE}")
    assert_nil TenantHost.tenant_for(PRODUCTION_BASE)
  end

  def test_case_and_port_are_normalized
    configure(STAGING_BASE)
    assert_equal 'abc', TenantHost.tenant_for("ABC.#{STAGING_BASE.upcase}")
    assert_equal 'abc', TenantHost.tenant_for("abc.#{STAGING_BASE}:443")
  end

  # --- URL generation helper ---

  def test_host_for_builds_tenant_host_on_base_domain
    configure(STAGING_BASE)
    assert_equal "abc.#{STAGING_BASE}", TenantHost.host_for('abc', STAGING_BASE)
  end

  def test_host_for_replaces_existing_tenant
    configure(STAGING_BASE)
    assert_equal "xyz.#{STAGING_BASE}", TenantHost.host_for('xyz', "abc.#{STAGING_BASE}")
  end

  def test_host_for_without_tenant_returns_base
    configure(STAGING_BASE)
    assert_equal STAGING_BASE, TenantHost.host_for(nil, "abc.#{STAGING_BASE}")
    assert_equal STAGING_BASE, TenantHost.host_for('', STAGING_BASE)
  end
end
