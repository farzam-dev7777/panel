class Admin::ReviewsController < Admin::BaseController

  layout 'admin'
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @q = FaqCategory.ransack(params[:q])
    @faq_categories = @q.result(distinct: true).paginate(page: params[:page])
  end
  
  def create
    ActiveRecord::Base.transaction do
      @reviewable = params[:review][:reviewable_type].constantize.find_by(id: params[:review][:reviewable_id])
      @review = @reviewable.reviews.build(review_params.merge(
        {
          actor_id: current_user.id,
          pay_type: params[:review][:pay_type],
          status_from: current_user.role === 'lxp' ? @reviewable.lxp_status : @reviewable.internal_lawyers_status
        }
      ))

      if @review.save
        if params[:review][:reviewable_type] == "ExceptionRequest"
          
          @exception_request = ExceptionRequest.find_by_id(params[:review][:reviewable_id])
          if current_user.role === 'lxp' && review_params[:status] == 'APPROVED'
            # pay tyep
            @user = User.find_by_id(@exception_request.user_id)
            signer_email = @user.email
            signer_name =  @user.username
            @exception_request.send_retainer_for_esigning(signer_email, signer_name)
            ExceptionRequestMailer.form_status_notification_to_lob_for_sign(@exception_request).deliver_now
          elsif current_user.role === 'lxp' && review_params[:assigned_to_id].present?
            ExceptionRequestMailer.form_status_notification_to_internal_lawyer(@exception_request,params[:review][:assigned_to_id]).deliver_now
          elsif
            current_user.role === 'internal_lawyers' && review_params[:status] == 'APPROVED'
            ExceptionRequestMailer.form_status_notification_to_lxp(@exception_request).deliver_now
          else
            if current_user.role === 'internal_lawyers'
              ExceptionRequestMailer.form_status_notification_to_lxp(@exception_request).deliver_now
              ExceptionRequestMailer.form_status_notification_to_lob(@exception_request).deliver_now
            else
              ExceptionRequestMailer.form_status_notification_to_lob(@exception_request).deliver_now
            end
          end
        elsif params[:review][:reviewable_type] == "PanelRequest"
          @panel_request = PanelRequest.find_by_id(params[:review][:reviewable_id])
          @panel_request.lxp_status = review_params[:status]
         
          if current_user.role === 'lxp' &&  review_params[:status] == 'PANEL_RETAINER'
            @lob = User.find_by_id(@panel_request.user_id)
            lob_email = @lob.email
            lob_name =  @lob.username

            @user = @panel_request.law_firm.user
            user_email = @user.email
            user_name =  @user.username

            @panel_request.send_retainer_for_esigning(lob_email, lob_name, user_email, user_name)
            if review_params[:status] == 'PANEL_RETAINER'
              PanelRequestMailer.notification_for_retainer_to_law_firm(@panel_request).deliver_now
            else
              PanelRequestMailer.notification_for_retainer_to_lob(@panel_request).deliver_now
            end
            PanelRequestMailer.notification_for_retainer_to_user(@panel_request).deliver_now
          elsif current_user.role === 'lxp' &&  review_params[:status] == 'REJECTED'
            PanelRequestMailer.notification_for_rejected_to_user(@panel_request).deliver_now
          elsif current_user.role === 'lxp' &&  review_params[:status] == 'APPROVED'
            @panel_request.status = 'Activate'
            @panel_request.law_firm.status = 'Activate'
            @user = @panel_request.law_firm.user
            @user.status = 'Activate'
            @user.save
            PanelRequestMailer.notification_for_approved_to_lob(@panel_request).deliver_now
            PanelRequestMailer.notification_for_approved_to_user(@panel_request).deliver_now
          else
            PanelRequestMailer.notification_for_more_info_to_lob(@panel_request).deliver_now
          end
          @panel_request.save
        else
          @conflict_waiver = ConflictWaiver.find_by_id(params[:review][:reviewable_id])
          if current_user.role === 'lxp' && ( review_params[:status] == 'APPROVED' && review_params[:assigned_to_id].present?)
      
            ConflictWaiverMailer.form_status_notification_to_internal_lawyer(@conflict_waiver,params[:review][:assigned_to_id]).deliver_now
            #ConflictWaiverMailer.form_status_approved_notification_to_law_firm_by_lxp(@conflict_waiver).deliver_now 
          elsif current_user.role === 'internal_lawyers' && review_params[:status] == 'APPROVED'
            @conflict_waiver.update_attributes(lxp_status: review_params[:status])
            ConflictWaiverMailer.form_status_notification_to_lxp_by_internal_lawyers(@conflict_waiver).deliver_now 
            ConflictWaiverMailer.form_status_notification_to_user(@conflict_waiver).deliver_now
          elsif current_user.role === 'internal_lawyers' && review_params[:status] == 'REQUEST_INFO'
            @conflict_waiver.update_attributes(lxp_status: review_params[:status])
            ConflictWaiverMailer.form_status_notification_to_lxp_for_info_internal_lawyers(@conflict_waiver).deliver_now 
          else
           if current_user.role === 'lxp' &&  review_params[:status] == 'ALREADY_COVERED'
            ConflictWaiverMailer.form_status_notification_to_user(@conflict_waiver).deliver_now
           elsif current_user.role === 'internal_lawyers' &&  review_params[:status] == 'REJECTED'
            @conflict_waiver.update_attributes(lxp_status: review_params[:status])
            ConflictWaiverMailer.form_status_notification_to_user(@conflict_waiver).deliver_now
            ConflictWaiverMailer.form_status_notification_to_lxp_by_internal_lawyers(@conflict_waiver).deliver_now 
           else
            ConflictWaiverMailer.form_status_notification_to_user(@conflict_waiver).deliver_now
           end
          end
        end
        redirect_to :back, notice: "Review Added"


      else
        flash.now[:alert] = @review.errors.full_messages.join(', ')
        render :new
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:description, :status, :assigned_to_id, :pay_type)
  end

end
