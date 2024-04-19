class Admin::InvoicesController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Dashboard", :root_path


  def index
    @invoices = Invoice.order('updated_at DESC')
  end

end