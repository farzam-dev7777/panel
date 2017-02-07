class Admin::InternalDashboardController < Admin::BaseController

  layout 'admin'

  def index
  	@q = LawFirm.ransack(params[:q])
    @law_firms = @q.result(distinct: true).limit(5)
  end

  def show
  	@law_firms = LawFirm.all.limit(4)
  end

end
