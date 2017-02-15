class Admin::MessagesController < Admin::BaseController
  layout 'admin'

  add_breadcrumb "Admin", :admin_root_path

  def index
    add_breadcrumb "Messages"
    conversations = current_admin_user.mailbox.inbox.order('created_at DESC').limit(20)
    @conversations = ConversationDecorator.decorate_collection(conversations)
  end

  def show
    add_breadcrumb "Messages"
    @conversation = current_admin_user.mailbox.inbox.find(params[:id])
    add_breadcrumb @conversation.subject
  end

  def create
    law_firm = LawFirm.find_by(id: params[:message][:law_firm_id])
    receipt = current_admin_user.send_message(law_firm, params[:message][:body], params[:message][:subject])
    if receipt.persisted?
      render json: :ok
    else
      render json: :error, status: 422
    end
  end

end
