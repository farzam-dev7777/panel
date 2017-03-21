class Admin::InternalDashboardController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Dashboard", :root_path

  ACTIVITY_LOG_DAYS = 10

  def index
    @law_firms = LawFirm.distinct.joins(:form_submissions).order('law_firms.updated_at').limit(5)
    @activity_logs = ActivityLog.where('created_at > ?', ACTIVITY_LOG_DAYS.days.ago).order('created_at DESC')
    @security_threats = SecurityThreat.distinct.joins('INNER JOIN action_items ON action_items.security_threat_id =  security_threats.id').joins('INNER JOIN queued_notifications ON queued_notifications.action_item_id = action_items.id').where('queued_notifications.triggered = false').limit(5)
  end

  def show
  	@law_firms = LawFirm.all.limit(4)
  end

  def notifications
    @law_firms = LawFirm.distinct.joins(:form_submissions).where("form_submissions.status = 'approved'")
  end

  def search_activity_logs
    query = params[:query].blank? ? "% %" : "%#{params[:query].downcase}%"
    @activity_logs = ActivityLog.joins('INNER JOIN law_firms ON law_firms.id = activity_logs.law_firm_id').where('lower(law_firms.name) LIKE ? OR lower(custom_message) LIKE ? OR lower(event_type) LIKE ?', query, query, query)
    render partial: 'activity_log', locals: {activity_logs: @activity_logs}
  end

  def seal_stats
    certified = LawFirm.joins(:form_submissions).where("form_submissions.created_at = (SELECT MAX(form_submissions.created_at) FROM form_submissions WHERE form_submissions.law_firm_id = law_firms.id) AND form_submissions.status='approved'").group("DATE_TRUNC('month', form_submissions.created_at)").count
    decertified = LawFirm.joins(:form_submissions).where("form_submissions.created_at = (SELECT MAX(form_submissions.created_at) FROM form_submissions WHERE form_submissions.law_firm_id = law_firms.id) AND form_submissions.status='decertified'").group("DATE_TRUNC('month', form_submissions.created_at)").count
    under_process = LawFirm.joins(:form_submissions).where("form_submissions.created_at = (SELECT MAX(form_submissions.created_at) FROM form_submissions WHERE form_submissions.law_firm_id = law_firms.id) AND form_submissions.status='sent'").group("DATE_TRUNC('month', form_submissions.created_at)").count
    render json: {certified: certified, decertified: decertified, under_process: under_process}
  end

  def load_more_activities
    last_timestamp = Date.parse(params[:last_timestamp])
    activity_logs = ActivityLog.where('created_at < ?', last_timestamp).order('created_at DESC')
    render partial: 'activity_log', locals: {activity_logs: activity_logs}
  end

end
