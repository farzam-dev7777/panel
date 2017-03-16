class SystemSetting < ApplicationRecord
	# has_paper_trail

	def self.score_threshold
		SystemSetting.last.try(:score_threshold) || 0
	end
end
