class AddLawFirmTenantsAttributes < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms_tenants, :bmo_relationship_partner_name, :string
    add_column :law_firms_tenants, :bmo_relationship_partner_email, :string
    add_column :law_firms_tenants, :bmo_relationship_partner_phone_number, :string
    add_column :law_firms_tenants, :secondary_rm_contact, :string
    add_column :law_firms_tenants, :secondary_rm_contact_email, :string
    add_column :law_firms_tenants, :billing_contact_name, :string
    add_column :law_firms_tenants, :billing_contact_email, :string
    add_column :law_firms_tenants, :engagement_number, :string
    add_column :law_firms_tenants, :relationship_number, :string
    add_column :law_firms_tenants, :information_security_class, :string
    add_column :law_firms_tenants, :information_security_assessment_outcome, :string
    add_column :law_firms_tenants, :action_plan_findings, :string
    add_column :law_firms_tenants, :action_plan_status, :string
    add_column :law_firms_tenants, :information_security_contact, :string
    add_column :law_firms_tenants, :information_security_contact_email, :string
  end
end
