class Admin::ReviewsController < Admin::BaseController

  layout 'admin'
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @q = FaqCategory.ransack(params[:q])
    @faq_categories = @q.result(distinct: true).paginate(page: params[:page])
  end
  
  def create

    @reviewable = params[:review][:reviewable_type].constantize.find_by(id: params[:review][:reviewable_id])
    @review = @reviewable.reviews.build(review_params.merge(
      {
        actor_id: current_user.id,
        status_from: current_user.role === 'lxp' ? @reviewable.lxp_status : @reviewable.internal_lawyers_status
      }
    ))
    if @review.save
      @conflict_waiver = ConflictWaiver.find_by_id(params[:review][:reviewable_id])
      if current_user.role === 'lxp' && ( review_params[:status] == 'APPROVED' && review_params[:assigned_to_id].present?)
  
        ConflictWaiverMailer.form_status_notification_to_internal_lawyer(@conflict_waiver,params[:review][:assigned_to_id]).deliver_now
        #ConflictWaiverMailer.form_status_approved_notification_to_law_firm_by_lxp(@conflict_waiver).deliver_now 
      elsif
        current_user.role === 'internal_lawyers' && ( review_params[:status] == 'APPROVED' && review_params[:assigned_to_id].present?)
        ConflictWaiverMailer.form_status_notification_to_lxp_by_internal_lawyers(@conflict_waiver).deliver_now 
        ConflictWaiverMailer.form_status_notification_to_user(@conflict_waiver).deliver_now
      else

        ConflictWaiverMailer.form_status_notification_to_user(@conflict_waiver).deliver_now
      end
     
      redirect_to :back, notice: "Review Added"


    else
      flash.now[:alert] = @review.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:description, :status, :assigned_to_id)
  end

end
