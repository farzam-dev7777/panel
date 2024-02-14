class Tenant < ApplicationRecord
    after_create_commit :create_db_schema

    validates_presence_of :name, :subdomain
    validates_uniqueness_of :subdomain

    validates :subdomain, exclusion: { in: %w(www panel seal bank),
    message: "%{value} is reserved." }

    self.per_page = 10

    has_many :users
    has_many :law_firms_tenants
    has_many :law_firms, through: :law_firms_tenants
    has_many :tenant_matter_approvals
    has_many :line_of_businesses
    has_many :tenant_questions

    mount_uploader :logo, TenantUploader
    mount_uploader :login_bg_image, TenantUploader

    serialize :auto_approve_matter_type, Array
    serialize :matter_optional_fields, Array

    accepts_nested_attributes_for :tenant_matter_approvals
    accepts_nested_attributes_for :tenant_questions, reject_if: :all_blank, allow_destroy: true


    def create_db_schema
        Apartment::Tenant.create(subdomain)
    end

    def self.current
        Tenant.find_by subdomain: Apartment::Tenant.current
    end

    def within_tenant(&block)
      Apartment::Tenant.switch(self.subdomain) do
        block.call
      end
    end

    def fetch_role(group_name)
      case group_name
        when (self.internal_lawyer.present? ? self.internal_lawyer : 'Panel - Internal Lawyers')
          "internal_lawyers"
        when (self.master_user.present? ? self.master_user : "Panel - Master User")
          "lxp"
        when (self.business_user.present? ? self.business_user : "Panel - Business User")
          "lob"
        else
          ""
      end
    end

    def create_default_matter_approvals
        data = {0 => 'First', 1 => 'Second', 2=> 'Third', 3=> 'Fourth'}
        MatterApproval::MATTER_APPROVAL_ROLE.keys.each do |role, name|
            MatterApproval::MATTER_APPROVAL_ROLE.select{|key, value| key != role}.each_with_index do |role1, index|
                self.tenant_matter_approvals.create(approval_type: 'approval', owner_role: role, role: role1.first, approval:true, notification:true, title: "#{data[index]} Approval", sequence_number: 0)
                self.tenant_matter_approvals.create(approval_type: 'consent', owner_role: role, role: role1.first, approval:true, notification:true, title: "#{data[index]} Consent", sequence_number: 0)
            end
        end
    end
end
