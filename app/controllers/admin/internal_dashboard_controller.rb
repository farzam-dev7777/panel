class Admin::InternalDashboardController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Admin", :root_path

  def index
    @q = LawFirm.ransack(params[:q])
    conversations = current_admin_admin_user.mailbox.conversations.order('created_at DESC').limit(10)
    @conversations = ConversationDecorator.decorate_collection(conversations)
    @law_firms = @q.result(distinct: true)
    @activity_logs = ActivityLog.all
  end

  def show
  	@law_firms = LawFirm.all.limit(4)
  end

  def notifications
    render locals: {
      vendors: Technology.all.decorate
    }
  end

end
