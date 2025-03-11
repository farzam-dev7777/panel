class Admin::InvoicesController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Dashboard", :root_path


  def index
    @invoices = Invoice.order('updated_at DESC')
  end

  def show
    @invoice = Invoice.find_by_id params[:id]
    @matter_intake = @invoice.matter_intake
  end

end