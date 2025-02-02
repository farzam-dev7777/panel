class RfpsController < BaseController

  before_action :check_tenant_rfp

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
    @rfp_invite = @rfp.rfp_invites.find_by_law_firm_id current_user.law_firm.id
  end

  def check_tenant_rfp
    if Tenant.current&.rfp_enable.blank?
      redirect_back fallback_location: admin_root_path, alert: "RFP is not enabled"
    end
  end
end