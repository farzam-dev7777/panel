class RfpsController < BaseController

	def accpect_invite
		rfp_invite = RfpInvite.find_by_id params[:rfp_invite_id]
		if rfp_invite.update(status:'accpeted')
			redirect_to root_url, notice: "RFP invite accpeted"
		else
			redirect_to root_url, error: "RFP invite cannot accpeted"
		end
	end

	def show
		@rfp = Rfp.find_by_id params[:id]
		@matter_intake = @rfp.matter_intake
	end
end