class Admin::ProposalsController< Admin::BaseController
  layout 'admin'

  def index
    @rfp = Rfp.find_by_id params[:rfp_id]
  end

  def show
    @proposal = Proposal.find_by_id params[:id]
    @rfp = @proposal.rfp
  end

  def add_comment
    @proposal = Proposal.find_by_id(params[:id])
    @proposal.proposal_comments.create(user_id: current_user.id, message: params[:comment])
    redirect_back fallback_location: root_path
  end

  def accept
    @proposal = Proposal.find_by_id params[:id]
    if @proposal.update(status: 'approved')
      @proposal.rfp.update(status: 'closed')
      @proposal.rfp.matter_intake.update(status: 'opened')
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path
    end
  end
end