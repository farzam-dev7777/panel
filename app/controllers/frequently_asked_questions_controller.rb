class FrequentlyAskedQuestionsController < BaseController

  def index
    @faq_categories = FaqCategory.all
  	# @q = FrequentlyAskedQuestion.ransack(params[:q])
   #  @faqs = @q.result(distinct: true).paginate(page: params[:page])
  end

end
