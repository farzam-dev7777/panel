class Admin::CommentsController < Admin::BaseController

  layout 'admin'
  skip_before_action :authenticate_user!, only: [:show]

  def create
    
    ActiveRecord::Base.transaction do
      @commentable = params[:comment][:commentable_type].constantize.find_by(id: params[:comment][:commentable_id])
      @comment = @commentable.comments.build(comment_params)
      if @comment.save
        redirect_to :back, notice: "comment Added"
      else
       # flash.now[:alert] = @comment.errors.full_messages.join(', ')
        redirect_to :back, alert: @comment.errors.full_messages.join(', ')
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id, :user_id, :assigned_to_id)
  end

end
# @exception_request = ExceptionRequest.find_by_id(params[:comment][:commentable_id])
# if current_user.role === 'lxp' && comment_params[:status] == 'APPROVED'
#   # pay tyep
#   @exception_request.update_attributes(lxp_status: comment_params[:status])
#   # @user = User.find_by_id(@exception_request.user_id)
#   # signer_email = @user.email
#   # signer_name =  @user.username
#   # @exception_request.send_retainer_for_esigning(signer_email, signer_name)
#   # ExceptionRequestMailer.form_status_notification_to_lob_for_sign(@exception_request).deliver_now
# elsif current_user.role === 'lxp' && comment_params[:assigned_to_id].present?
#   ExceptionRequestMailer.form_status_notification_to_internal_lawyer(@exception_request,params[:comment][:assigned_to_id]).deliver_now
# elsif current_user.role === 'lxp' && comment_params[:status] == 'RETAINER_AGREEMENT_SENT'
#   @exception_request.update_attributes(lxp_status: comment_params[:status])
# elsif current_user.role === 'internal_lawyers' && comment_params[:status] == 'APPROVED'
#   @exception_request.update_attributes(lxp_status: "commentED_BY_LAWYER")
#   ExceptionRequestMailer.form_status_notification_to_lxp(@exception_request).deliver_now
# else
#   if current_user.role === 'internal_lawyers'
#     @exception_request.update_attributes(lxp_status: "commentED_BY_LAWYER")
#     ExceptionRequestMailer.form_status_notification_to_lxp(@exception_request).deliver_now
#     ExceptionRequestMailer.form_status_notification_to_lob(@exception_request).deliver_now
#   else
#     ExceptionRequestMailer.form_status_notification_to_lob(@exception_request).deliver_now
#   end
# end