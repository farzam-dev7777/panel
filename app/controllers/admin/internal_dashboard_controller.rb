class Admin::InternalDashboardController < Admin::BaseController

  layout 'admin'

  def index
    @q = LawFirm.ransack(params[:q])
    conversations = current_admin_user.mailbox.conversations.order('created_at DESC').limit(10)
    @conversations = ConversationDecorator.decorate_collection(conversations)
    @law_firms = @q.result(distinct: true).limit(5)
  end

  def show
  	@law_firms = LawFirm.all.limit(4)
  end

end
