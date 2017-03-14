class Admin::InternalDashboardController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Admin", :root_path

  def index
    @law_firms = LawFirm.distinct.joins(:form_submissions).where('form_submissions.status = ?', 'approved').limit(5)
    @activity_logs = ActivityLog.all
  end

  def show
  	@law_firms = LawFirm.all.limit(4)
  end

  def notifications
    @law_firms = LawFirm.distinct.joins(:form_submissions).where("form_submissions.status = 'approved'")
  end

end
