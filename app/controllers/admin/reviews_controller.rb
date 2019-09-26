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
      redirect_to :back, notice: "Review Added"
    else
      flash.now[:alert] = @review.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:description, :status)
  end

end
