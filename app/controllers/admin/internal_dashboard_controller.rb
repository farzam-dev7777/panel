class Admin::InternalDashboardController < Admin::BaseController

  layout 'admin'

  add_breadcrumb "Dashboard", :root_path
  before_filter :set_search

  ACTIVITY_LOG_DAYS = 10

  def index
    if current_user.role === "lxp"
      @exception_requests = ExceptionRequest.distinct.order('created_at DESC').limit(5)
      @conflict_waivers = ConflictWaiver.distinct.order('created_at DESC').limit(5)
      @matter_intakes = MatterIntake.distinct.order('created_at DESC').limit(5)
      @matter_open_intakes_count = MatterIntake.distinct.where(status: "matter_open").count()
      @matter_intakes_count = MatterIntake.distinct.order('created_at DESC').count()

      @law_firms = LawFirm.distinct.joins(:form_submissions).order('law_firms.updated_at DESC').limit(5)
      @panel_requests = PanelRequest.order('created_at DESC').limit(5)
      @exception_requests_submitted = ExceptionRequest.where( lxp_status: [nil, ""]).count()
      @confilictc_requests_submitted = ConflictWaiver.where(lxp_status: [nil, ""]).count()
      @panel_requests_submitted = PanelRequest.count()

    elsif current_user.role === "internal_lawyers"
      @exception_requests = ExceptionRequest.where( lxp_status: [nil, ""], internal_lawyers_id: current_user.id).or( ExceptionRequest.where( lxp_status: [nil, ""], user_id: current_user.id) ).limit(5)
      @conflict_waivers = ConflictWaiver.where(assigned_to_id: current_user.id).order('created_at DESC').limit(5)
      @matter_intakes = MatterIntake.where(lawyer_id: current_user.id).order('created_at DESC').limit(5)
      @matter_intakes_count = MatterIntake.where(lawyer_id: current_user.id).count()

      @law_firms = LawFirm.distinct.joins(:form_submissions).order('law_firms.updated_at DESC').limit(5)
      @panel_requests = PanelRequest.where(user_id: current_user.id).limit(5)
      @exception_requests_submitted = ExceptionRequest.where( lxp_status: [nil, ""], internal_lawyers_id: current_user.id).or( ExceptionRequest.where( lxp_status: [nil, ""], user_id: current_user.id) ).count()
      @confilictc_requests_submitted = ConflictWaiver.where(lxp_status: [nil, ""]).count()
      @panel_requests_submitted = PanelRequest.where(user_id: current_user.id).count()
      
    else
      @exception_requests = ExceptionRequest.where(user_id: current_user.id).order('created_at DESC').limit(5)
      @conflict_waivers = []
      @matter_intakes = []
      @matter_intakes_count = 0

      @law_firms = LawFirm.distinct.joins(:form_submissions).order('law_firms.updated_at DESC').limit(5)
      @panel_requests = PanelRequest.order('created_at DESC').limit(5)
      @exception_requests_submitted = ExceptionRequest.where( lxp_status: [nil, ""]).count()
      @confilictc_requests_submitted = ConflictWaiver.where(lxp_status: [nil, ""]).count()
      @panel_requests_submitted = PanelRequest.where(user_id: current_user.id).count()
    end

 
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
