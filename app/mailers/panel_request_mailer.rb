class PanelRequestMailer < ApplicationMailer
	default from: "info@panel.grcx.io"
	layout 'mailer'

	def panel_request_notification_to_lxp(panel_request)
		@panel_request = panel_request
		@lxpusers = User.where(role: 'lxp')
		@lxpusers.each do |lxpuser| 
			mail(to: lxpuser.email, subject: "A New Panel Request has been submitted.")
		end
	end

	def panel_request_update_notification_to_lxp(panel_request)
		@panel_request = panel_request
		@lxpusers = User.where(role: 'lxp')
		@lxpusers.each do |lxpuser| 
			mail(to: lxpuser.email, subject: "A New Panel Request has been updated.")
		end
	end
	def notification_for_more_info_to_lob(panel_request)
		@panel_request = panel_request
		@user = User.find_by_id(@panel_request.user_id)
		mail(to: @user.email, subject: "Requested For More About Panel Request.")
	end

	def notification_for_rejected_to_user(panel_request)
		@panel_request = panel_request
		@user = User.find_by_id(@panel_request.user_id)
		mail(to: @user.email, subject: "Your Panel Request status has been rejected.")
	end

	def notification_for_retainer_to_lob(panel_request)
		@panel_request = panel_request
		@user = User.find_by_id(@panel_request.user_id)
		mail(to: @user.email, subject: "Your Panel Request status has been updated.")
	end
	def notification_for_retainer_to_law_firm(panel_request)
		@panel_request = panel_request
		@user = User.with_deactivated.find_by_id(@panel_request.user_id)
		@law_firm = @panel_request.law_firm
		mail(to: @law_firm.email, subject: "Your Panel Request status has been updated.")
	end
	def notification_for_retainer_to_user(panel_request)
		@panel_request = panel_request
		user_id = @panel_request.law_firm.user_id
		@user = User.with_deactivated.find_by(id: user_id)
		if @user.present?
			mail(to: @user.email, subject: "Your Panel Request status has been updated.")
		end
	end
	def notification_for_approved_to_lob(panel_request)
		@panel_request = panel_request
		@user = User.find_by_id(@panel_request.user_id)
		mail(to: @user.email, subject: "Your Panel Request status has been approved.")
	end
	def notification_for_approved_to_user(panel_request)
		@panel_request = panel_request
		@user = @panel_request.law_firm.user
		mail(to: @user.email, subject: "Your Panel Request status has been approved.")
	end

	def notification_for_status_to_user(panel_request)
		@panel_request = panel_request
		@user = User.find_by_id(@panel_request.user_id)
		mail(to: @user.email, subject: "Your Panel Request status has been updated.")
	end
	def send_wnn_documents_to_law_firm(panel_request)
		@panel_request = panel_request
		@law_firm = @panel_request&.law_firm
		attachments['WNN_Documents.zip'] = File.read("#{Rails.root}/lib/assets/WNN_Documents.zip")
		mail(to: @law_firm.email, subject: "WNN Documents")
	end



	


	# def form_submission_notification_to_lob(exception_request)
	# 	@exception_request = exception_request
	# 	@user = User.find_by_id(exception_request.user_id)
	# 	mail(to: @user.email, subject: "A New Engage Non Panel Request submitted.")
	# end

  # def form_submission_notification_to_lxp(exception_request)
	# 	@exception_request = exception_request
	# 	@user = @exception_request.try(:user)
	# 	@lxpusers = User.where(role: 'lxp')
	# 	@lxpusers.each do |lxpuser| 
	# 		mail(to: lxpuser.email, subject: "A New Engage Non Panel Request has been submitted.")
	# 	end
	# end

	# def form_status_notification_to_internal_lawyer(exception_request,assigned_to_id)
	# 	@exception_request = exception_request
	# 	@lawyer = User.find_by_id(assigned_to_id)
	# 	mail(to: @lawyer.email, subject: "A New Engage Non Panel Request has been submited to review.")
	# end

	# def form_status_notification_to_lob(exception_request)
		
	# 	@exception_request = exception_request
	# 	@user = User.with_deactivated.find_by_id(exception_request.user_id)
	# 	mail(to: @user.email, subject: "Your Engage Non Panel Request status has been updated.")
	# end
	# def form_status_notification_to_lob_for_sign(exception_request)
		
	# 	@exception_request = exception_request
	# 	@user = User.with_deactivated.find_by_id(exception_request.user_id)
	# 	mail(to: @user.email, subject: "Your Engage Non Panel Request status has been approved and send Non Panel Retainer.")
	# end
	
	
	# def form_status_notification_to_lxp(exception_request)
	# 	@exception_request = exception_request
	# 	@user = User.find_by_id(exception_request.lxp_id)
	# 	mail(to: @user.email, subject: "Engage Non Panel Request status has been updated by Lawyer.")
	# end

	# def form_status_notification_to_law_firm(exception_request)
	# 	@exception_request = exception_request
	# 	@user = User.with_deactivated.find_by_id(	@exception_request.user_id)
	# 	mail(to: @user.email, subject: "Engage Non Panel Request status has been updated.")
	# end

	# def engage_non_panel_firm_notification_to_lxp(exception_request)
	# 	@exception_request = exception_request
	# 	@user = User.find_by_id(exception_request.user_id)
	# 	@lxpusers = User.where(role: 'lxp')
	# 	@lxpusers.each do |lxpuser| 
	# 		mail(to: lxpuser.email, subject: "A New Engage Non Panel Request try to submited with below search criteria.")
	# 	end
	# end

	# def engage_new_non_panel_firm_notification_to_lxp(exception_request)
	# 	@exception_request = exception_request
	# 	@user = User.find_by_id(exception_request.user_id)
	# 	@lxpusers = User.where(role: 'lxp')
	# 	@lxpusers.each do |lxpuser| 
	# 		mail(to: lxpuser.email, subject: "New Engage Non Panel Request submited ")
	# 	end
	# end

	# def form_updated_notification_to_lxp(conflict_waiver)
	# 	@conflict_waiver = conflict_waiver
	# 	@user = @conflict_waiver.try(:user)
	# 	@lxpusers = User.where(role: 'lxp')
	# 	@lxpusers.each do |lxpuser| 
	# 		mail(to: lxpuser.email, subject: "#{@conflict_waiver.name_of_law_firm} has been updated.")
	# 	end
	# end

	# def form_submited_notification_to_user(conflict_waiver)
	# 	@conflict_waiver = conflict_waiver
	# 	@user = User.find_by_id(conflict_waiver.user_id)
	# 	mail(to: @user.email, subject: "A New Conflict Waiver #{conflict_waiver.name_of_law_firm} reqeust submitted.")
	# end

	# def form_status_notification_to_user(conflict_waiver)
	# 	@conflict_waiver = conflict_waiver
	# 	@user = User.find_by_id(conflict_waiver.user_id)
	# 	mail(to: @user.email, subject: "Your Request #{conflict_waiver.name_of_law_firm}  status has been updated.")
	# end

	# def form_update_notification_to_user(conflict_waiver)
	# 	@conflict_waiver = conflict_waiver
	# 	@user = User.find_by_id(conflict_waiver.user_id)
	# 	mail(to: @user.email, subject: "Your Request #{conflict_waiver.name_of_law_firm}  status has been updated.")
	# end

	# def form_status_notification_to_internal_lawyer(conflict_waiver,assigned_to_id)
	# 	@conflict_waiver = conflict_waiver
	# 	@lawyer = User.find_by_id(assigned_to_id)
	# 	mail(to: @lawyer.email, subject: "#{conflict_waiver.name_of_law_firm} has been submited to review.")
	# end

	# def form_status_approved_notification_to_law_firm_by_lxp(conflict_waiver)
	# 	@conflict_waiver = conflict_waiver
	# 	@user = User.find_by_id(conflict_waiver.user_id)
	# 	mail(to: @user.email, subject: "#{conflict_waiver.name_of_law_firm}  status has been Appove .")
	# end

	# def form_status_notification_to_law_firm_by_lxp(conflict_waiver)
	# 	@conflict_waiver = conflict_waiver
	# 	@user = User.find_by_id(conflict_waiver.user_id)
	# 	mail(to: @user.email, subject: "#{conflict_waiver.name_of_law_firm}  status has been updatd.")
	# end

	# def form_status_notification_to_lxp_by_internal_lawyers(conflict_waiver)
	# 	@conflict_waiver = conflict_waiver
	# 	@user = User.find_by_id(conflict_waiver.user_id)
	# 	mail(to: @user.email, subject: "#{conflict_waiver.name_of_law_firm} status has been updatd.")
	# end
end
