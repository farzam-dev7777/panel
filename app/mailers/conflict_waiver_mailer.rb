class ConflictWaiverMailer < ApplicationMailer
	default from: "info@panel.grcx.io"
	layout 'mailer'

  def form_submited_notification_to_lxp(conflict_waiver)
		@conflict_waiver = conflict_waiver
		@user = @conflict_waiver.try(:user)
		@lxpusers = User.where(role: 'lxp')
		@lxpusers.each do |lxpuser| 
			mail(to: lxpuser.email, subject: "#{@conflict_waiver.name_of_law_firm} has been submitted.")
		end
	end

	def form_updated_notification_to_lxp(conflict_waiver)
		@conflict_waiver = conflict_waiver
		@user = @conflict_waiver.try(:user)
		@lxpusers = User.where(role: 'lxp')
		@lxpusers.each do |lxpuser| 
			mail(to: lxpuser.email, subject: "#{@conflict_waiver.name_of_law_firm} has been updated.")
		end
	end

	def form_submited_notification_to_user(conflict_waiver)
		@conflict_waiver = conflict_waiver
		@user = User.find_by_id(conflict_waiver.user_id)
		mail(to: @user.email, subject: "A New Conflict Waiver #{conflict_waiver.name_of_law_firm} reqeust submitted.")
	end

	def form_status_notification_to_user(conflict_waiver)
		@conflict_waiver = conflict_waiver
		@user = User.find_by_id(conflict_waiver.user_id)
		mail(to: @user.email, subject: "Your Request #{conflict_waiver.name_of_law_firm}  status has been updated.")
	end

	def form_update_notification_to_user(conflict_waiver)
		@conflict_waiver = conflict_waiver
		@user = User.find_by_id(conflict_waiver.user_id)
		mail(to: @user.email, subject: "Your Request #{conflict_waiver.name_of_law_firm}  status has been updated.")
	end

	def form_status_notification_to_internal_lawyer(conflict_waiver,assigned_to_id)
		@conflict_waiver = conflict_waiver
		@lawyer = User.find_by_id(assigned_to_id)
		mail(to: @lawyer.email, subject: "#{conflict_waiver.name_of_law_firm} has been submited to review.")
	end

	def form_status_approved_notification_to_law_firm_by_lxp(conflict_waiver)
		@conflict_waiver = conflict_waiver
		@user = User.find_by_id(conflict_waiver.user_id)
		mail(to: @user.email, subject: "#{conflict_waiver.name_of_law_firm}  status has been Appove .")
	end

	def form_status_notification_to_law_firm_by_lxp(conflict_waiver)
		@conflict_waiver = conflict_waiver
		@user = User.find_by_id(conflict_waiver.user_id)
		mail(to: @user.email, subject: "#{conflict_waiver.name_of_law_firm}  status has been updatd.")
	end

	def form_status_notification_to_lxp_by_internal_lawyers(conflict_waiver)
		@conflict_waiver = conflict_waiver
		@user = User.find_by_id(conflict_waiver.user_id)
		@lxpusers = User.where(role: 'lxp')
		@lxpusers.each do |lxpuser| 
			mail(to: lxpuser.email, subject: "#{conflict_waiver.name_of_law_firm} status has been updatd.")
		end

	end
	def form_status_notification_to_lxp_for_info_internal_lawyers(conflict_waiver)
		@conflict_waiver = conflict_waiver
		@user = User.find_by_id(conflict_waiver.user_id)
		@lawyer = User.find_by_id(conflict_waiver.assigned_to_id)
		@lxpusers = User.where(role: 'lxp')
		@lxpusers.each do |lxpuser| 
			mail(to: lxpuser.email, subject: "Lawyer Requested For More Info")
		end
	end
end
