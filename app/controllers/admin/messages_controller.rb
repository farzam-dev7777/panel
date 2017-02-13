class Admin::MessagesController < Admin::BaseController
  layout 'admin'

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
