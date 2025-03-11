class InvoicesController < BaseController

  def index

  end

  def show
    @invoice = Invoice.find_by_id params[:id]
  end

  def approve
    if current_user.is_panel_admin_user?
      invoice = Invoice.find_by_id params[:id]
      if invoice.update(status:'approved')
        redirect_back fallback_location: admin_root_path, notice: "Invoice updated"
      else
        flash[:alert] = "Invoice not updated"
        redirect_back fallback_location: admin_root_path
      end
    else
      flash[:alert] = "Access Denied"
      redirect_back fallback_location: admin_root_path
    end
  end

  def reject
    if current_user.is_panel_admin_user?
      invoice = Invoice.find_by_id params[:id]
      if invoice.update(status:'rejected')
        redirect_back fallback_location: admin_root_path, notice: "Invoice updated"
      else
        flash[:alert] = "Invoice not updated"
        redirect_back fallback_location: admin_root_path
      end
    else
      flash[:alert] = "Access Denied"
      redirect_back fallback_location: admin_root_path
    end
  end

end