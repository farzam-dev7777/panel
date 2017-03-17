class Admin::InternalDashboardController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Dashboard", :root_path

  def index
    @law_firms = LawFirm.distinct.joins(:form_submissions).where('form_submissions.status = ?', 'approved').limit(5)
    @activity_logs = ActivityLog.all
    @security_threats = SecurityThreat.distinct.joins('INNER JOIN action_items ON action_items.security_threat_id =  security_threats.id').joins('INNER JOIN queued_notifications ON queued_notifications.action_item_id = action_items.id').where('queued_notifications.triggered = false').limit(5)
  end

  def show
  	@law_firms = LawFirm.all.limit(4)
  end

  def notifications
    @law_firms = LawFirm.distinct.joins(:form_submissions).where("form_submissions.status = 'approved'")
  end

  def search_activity_logs
    query = params[:query].blank? ? "" : "%#{params[:query]}%"
    @activity_logs = ActivityLog.joins('INNER JOIN law_firms ON law_firms.id = activity_logs.law_firm_id').where('law_firms.name LIKE ? OR custom_message LIKE ?', query, query)
    render partial: 'activity_log', locals: {activity_logs: @activity_logs}
  end

end
