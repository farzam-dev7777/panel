class RequestsController < BaseController

	before_filter :find_law_firm

  def create
  	request = @law_firm.requests.build(request_type: params[:request_type], status: 'pending')
  	if (request.save)
  		redirect_to url_for(:controller => :dashboard, :action => :index)
  	end
  end

  private

  def find_law_firm
  	@law_firm = LawFirm.find_by(id: params[:id])
  end

end
