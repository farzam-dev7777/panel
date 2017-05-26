class TechnologyValue < ApplicationRecord

	attr_accessor :new_value

	scope :operating_systems,  		-> { where(platform_category: 'operating_systems') }
	scope :web_platforms,  				-> { where(platform_category: 'web_platforms') }
	scope :infosec_technologies,  -> { where(platform_category: 'infosec_technologies') }
	scope :storage_archival,  		-> { where(platform_category: 'storage_archival') }
	
	scope :server,  -> { where(platform_type: 'server') }
	scope :client,  -> { where(platform_type: 'client') }

	scope :hardware,  -> { where(platform_type: 'hardware') }
	scope :software,  -> { where(platform_type: 'software') }

	scope :internet,  -> { where(platform_type: 'internet') }
	scope :intranet,  -> { where(platform_type: 'intranet') }

	validates_presence_of :vendor, :platform, :version, :service_pack, :supported

	before_save :create_technology

	def create_technology
		Technology.create!(
			vendor: self.vendor,
		 	platform: self.platform,
		 	version: self.version,
		 	service_pack: self.service_pack,
		 	platform_category: self.platform_category,
		 	platform_type: self.platform_type
		 ) if self.new_value
	end

end
