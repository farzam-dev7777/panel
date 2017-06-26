class FrequentlyAskedQuestionsController < BaseController

  def index
  	@q = FrequentlyAskedQuestion.ransack(params[:q])
    @faqs = @q.result(distinct: true).paginate(page: params[:page])
  end

end
