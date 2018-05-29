class Admin::FrequentlyAskedQuestionsController < Admin::BaseController

  layout 'admin'
	skip_before_action :authenticate_user!, only: [:show]

  def index
  	@q = FrequentlyAskedQuestion.ransack(params[:q])
    @faqs = @q.result(distinct: true).paginate(page: params[:page])
  end

  def create
    @faq = FrequentlyAskedQuestion.new(faq_params)
    redirect_to :admin_frequently_asked_questions if @faq.save
  end

  def update
    @faq = FrequentlyAskedQuestion.find(params[:id])
    if @faq.update(faq_params)
      redirect_to :admin_frequently_asked_questions
    else
      render :edit, alert: @faq.errors.full_messages.join(', ')
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
  	@faq =  FrequentlyAskedQuestion.find(params[:id])
    alert_msg = ""
    if @faq 
      @faq.destroy
      alert_msg = "Security alert has been successfully deleted"
    else
      alert_msg = "We couldn't find the security alert in our database."
    end
    redirect_to admin_faqs_path, alert: alert_msg
  end

  private

  def faq_params
  	params.require(:frequently_asked_question).permit(:question, :answer)
  end

end
