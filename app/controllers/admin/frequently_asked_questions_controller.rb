class Admin::FrequentlyAskedQuestionsController < Admin::BaseController

  layout 'admin'
	skip_before_action :authenticate_user!, only: [:show]

  def index
  	@q = FrequentlyAskedQuestion.ransack(params[:q])
    @faqs = @q.result(distinct: true).paginate(page: params[:page])
  end

  def create
    @faq = FrequentlyAskedQuestion.new(faq_params)
    if @faq.save
      redirect_to :admin_frequently_asked_questions, notice: "Created successfully."
    else
      flash.now[:alert] = @faq.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    @faq = FrequentlyAskedQuestion.find(params[:id])
    if @faq.update(faq_params)
      redirect_to :admin_frequently_asked_questions, notice: "Updated successfully."
    else
      flash.now[:alert] = @faq.errors.full_messages.join(', ')
      render :edit
    end
  end

  def new
  	@faq = FrequentlyAskedQuestion.new
  end

  def edit
  	@faq = FrequentlyAskedQuestion.find(params[:id])
  end

  def show
    @faq =  FrequentlyAskedQuestion.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def destroy
  	@faq = FrequentlyAskedQuestion.find(params[:id])
    if @faq.destroy
      alert_msg = "FAQ has been successfully deleted"
      redirect_to admin_frequently_asked_questions_path, notice: alert_msg
    else
      redirect_to admin_frequently_asked_questions_path, alert: "Couldn't delete the FAQ"
    end
  end

  private

  def faq_params
  	params.require(:frequently_asked_question).permit(:question, :answer, :faq_category_id)
  end

end
