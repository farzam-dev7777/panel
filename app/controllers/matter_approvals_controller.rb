class MatterApprovalsController < BaseController

  def update
    matter_approval = MatterApproval.find_by(id: params[:id])
    matter_intake = matter_approval.matter_intake
    matter_status = ['approved', 'rejected'].include?(params[:matter_approval][:status]) ? params[:matter_approval][:status] : matter_approval.status
    if matter_approval.update(status: matter_status)
      matter_intake.auto_approve_matter(current_user) if params[:matter_approval][:status] == 'approved'
      matter_approval.matter_intake.reviews.create(status:  params[:matter_approval][:status], description: params[:matter_approval][:description], actor_id: current_user.id)
      if matter_intake.status != 'opened'
        matter_approval.matter_intake.update(status: 'opened') if matter_intake.matter_approvals.pending.blank? && matter_intake.matter_approvals.rejected.blank?
        matter_approval.matter_intake.update(status: 'closed') if matter_intake.matter_approvals.rejected.present?
        # matter_approval.matter_intake.update(status: 'opened') if matter_intake.matter_approvals.rejected.blank? && matter_intake.status == 'closed'
      end
      redirect_to matter_intake_path(matter_intake)
    else
      redirect_to matter_intake_path(matter_intake)
    end
  end

end
