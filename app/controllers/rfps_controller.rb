class RfpsController < BaseController

	def accept_invite
		rfp_invite = RfpInvite.find_by_id params[:rfp_invite_id]
		if rfp_invite.update(status:'accepted')
			redirect_to root_url, notice: "RFP invite accepted"
		else
			redirect_to root_url, error: "RFP invite cannot accepted"
		end
	end

	def show
		@rfp = Rfp.find_by_id params[:id]
		@matter_intake = @rfp.matter_intake
	end
end