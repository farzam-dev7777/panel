class Lob::InternalDashboardController < Lob::BaseController

  layout 'lob'

  add_breadcrumb "Dashboard", :root_path
  before_filter :set_search

  ACTIVITY_LOG_DAYS = 10

  def index
    @exception_requests = ExceptionRequest.where(user_id: current_user.id).order('created_at DESC').limit(5)
    @exception_requests_count = ExceptionRequest.where(user_id: current_user.id).count()
    @exception_requests_submitted = ExceptionRequest.where(user_id: current_user.id, internal_lawyers_status: [nil, ""]).count()
    @exception_requests_approved = ExceptionRequest.where(user_id: current_user.id, lxp_status: "APPROVED", internal_lawyers_status: "APPROVED").count()
    @exception_requests_rejected = ExceptionRequest.where(user_id: current_user.id, internal_lawyers_status: "REJECTED").count()
    @panel_requests = PanelRequest.where(user_id: current_user.id).order('created_at DESC').limit(5)
    @matter_intakes = MatterIntake.where(user_id: current_user.id).order('created_at DESC').limit(5)
  end

  def show
  	@law_firms = LawFirm.all.limit(4)
  end

  def notifications
    @law_firms = LawFirm.distinct.joins(:form_submissions).where("form_submissions.status = 'approved'")
  end

  def set_search
    @q = ActivityLog.search(params[:q])
  end

  def search_activity_logs
    if params[:q][:created_at_gteq]
      params[:q][:created_at_gteq] = Date.parse(params[:q][:created_at_gteq]).beginning_of_day
    end

    if params[:q][:created_at_lteq]
      params[:q][:created_at_lteq] = Date.parse(params[:q][:created_at_lteq]).end_of_day
    end
    @q = ActivityLog.ransack(params[:q])
    @activity_logs = @q.result.includes(:law_firm).order('created_at DESC')

    render partial: 'activity_log', locals: {activity_logs: @activity_logs}
  end

  def seal_stats
    under_process = {}
    certified = {}
    decertified = {}

    certified_count = LawFirm.certified.group("DATE_TRUNC('month', form_submissions.created_at)").count
    decertified_count = LawFirm.decertified.group("DATE_TRUNC('month', form_submissions.created_at)").count
    under_process_count = LawFirm.in_process.group("DATE_TRUNC('month', form_submissions.created_at)").count


    certified_count.each do |value|
      certified[value[0].strftime('%B')] = value[1]
    end
    under_process_count.each do |value|
      under_process[value[0].strftime('%B')] = value[1]
    end
    decertified_count.each do |value|
      decertified[value[0].strftime('%B')] = value[1]
    end
    render json: {certified: certified, decertified: decertified, under_process: under_process}
  end

  def load_more_activities
    last_timestamp = Date.parse(params[:last_timestamp])
    activity_logs = ActivityLog.where('created_at < ?', last_timestamp).order('created_at DESC')
    render partial: 'activity_log', locals: {activity_logs: activity_logs}
  end

end
