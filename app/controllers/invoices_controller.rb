class InvoicesController < BaseController

  def approve
    if current_user.is_panel_admin_user?
      invoice = Invoice.find_by_id params[:id]
      if invoice.update(status:'approved')
        redirect_to root_url, notice: "Invoice updated"
      else
        flash[:alert] = "Invoice not updated"
        redirect_to root_path
      end
    else
      flash[:alert] = "Access Denied"
      redirect_to root_path
    end
  end

  def reject
    if current_user.is_panel_admin_user?
      invoice = Invoice.find_by_id params[:id]
      if invoice.update(status:'rejected')
        redirect_to root_url, notice: "Invoice updated"
      else
        flash[:alert] = "Invoice not updated"
        redirect_to root_path
      end
    else
      flash[:alert] = "Access Denied"
      redirect_to root_path
    end
  end

end