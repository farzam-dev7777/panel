class ConflictWaiverMailer < ApplicationMailer

  def form_submited_notification_to_lxp(conflict_waiver)
		@conflict_waiver = conflict_waiver
		@user = @conflict_waiver.try(:user)
		@lxpusers = User.where(role: 'lxp')
		@lxpusers.each do |lxpuser| 
			mail(to: lxpuser.email, subject: "#{@conflict_waiver.name_of_law_firm} has been submited.")
		end
  
  end

end
