class InvoicesController < BaseController

  def index

  end

  def approve
    if current_user.is_panel_admin_user?
      invoice = Invoice.find_by_id params[:id]
      if invoice.update(status:'approved')
        redirect_to :back, notice: "Invoice updated"
      else
        flash[:alert] = "Invoice not updated"
        redirect_to :back
      end
    else
      flash[:alert] = "Access Denied"
      redirect_to :back
    end
  end

  def reject
    if current_user.is_panel_admin_user?
      invoice = Invoice.find_by_id params[:id]
      if invoice.update(status:'rejected')
        redirect_to :back, notice: "Invoice updated"
      else
        flash[:alert] = "Invoice not updated"
        redirect_to :back
      end
    else
      flash[:alert] = "Access Denied"
      redirect_to :back
    end
  end

end