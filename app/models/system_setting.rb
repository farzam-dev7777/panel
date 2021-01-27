class SystemSetting < ApplicationRecord
	# has_paper_trail

	def self.score_threshold
		SystemSetting.last.try(:score_threshold) || 0
	end

	def self.fetch
		@settings = SystemSetting.last || SystemSetting.create
	end
end
