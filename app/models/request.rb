class Request < ApplicationRecord

	after_create :log_activity

	def log_activity
  	object = {
  		law_firm_id: self.law_firm_id,
  		event_type: self.request_type,
  		loggable: self
  	}
  	ActivityLog.log(object)
  end

end
