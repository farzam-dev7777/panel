class Tenant < ApplicationRecord
	after_create_commit :create_db_schema

	validates_presence_of :name, :subdomain
	validates_uniqueness_of :subdomain

	validates :subdomain, exclusion: { in: %w(www panel seal bank),
    message: "%{value} is reserved." }

	self.per_page = 10
	
	has_many :users
	has_many :tenant_admin_users

	mount_uploader :logo, TenantUploader
	mount_uploader :login_bg_image, TenantUploader
	
	def create_db_schema
		Apartment::Tenant.create(subdomain)
	end

	def self.current
		Tenant.find_by subdomain: Apartment::Tenant.current
	end
end
