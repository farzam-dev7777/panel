class Admin::MatterApprovalsController < Admin::BaseController
  layout 'admin'

  add_breadcrumb "Dashboard", :root_path

  def update
    matter_approval = MatterApproval.find_by(id: params[:id])
    matter_intake = matter_approval.matter_intake
    matter_status = ['approved', 'rejected'].include?(params[:matter_approval][:status]) ? params[:matter_approval][:status] : matter_approval.status
    if matter_approval.update(status: matter_status)
      matter_intake.auto_approve_matter(current_user) if params[:matter_approval][:status] == 'approved'
      matter_approval.matter_intake.reviews.create(status:  params[:matter_approval][:status], description: params[:matter_approval][:description], actor_id: current_user.id)
      matter_intake.reload
      if matter_intake.status != 'approved'
        matter_approval.matter_intake.update(status: 'approved') if matter_intake.matter_approvals.pending.blank? && matter_intake.matter_approvals.rejected.blank?
        matter_approval.matter_intake.update(status: 'rejected') if matter_intake.matter_approvals.rejected.present?
        matter_approval.matter_intake.update(status: 'created') if matter_intake.matter_approvals.rejected.blank? && matter_intake.status == 'rejected'
      end
      redirect_to admin_matter_intakes_path
    else
      redirect_to admin_matter_intakes_path
    end
  end

end
