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

    mount_uploader :logo, TenantUploader
    mount_uploader :login_bg_image, TenantUploader

    serialize :auto_approve_matter_type, Array

    def create_db_schema
        Apartment::Tenant.create(subdomain)
    end

    def self.current
        Tenant.find_by subdomain: Apartment::Tenant.current
    end

    def fetch_role(group_name)
      case group_name
        when (self.internal_lawyer || 'Panel - Internal Lawyers')
          "internal_lawyers"
        when (self.master_user || "Panel - Master User")
          "lxp"
        when (self.business_user || "Panel - Business User")
          "lob"
        else
          ""
      end
    end
end
