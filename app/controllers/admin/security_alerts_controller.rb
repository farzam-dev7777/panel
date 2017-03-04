class Admin::SecurityAlertsController < Admin::BaseController

  layout 'admin'
	skip_before_filter :authenticate_admin_admin_user!, only: [:show]

  def index
  	@q = SecurityAlert.ransack(params[:q])
    @security_alerts = @q.result(distinct: true).paginate(page: params[:page])
  end

  def create
  	@security_alert = SecurityAlert.new(security_alert_params)
  	redirect_to :admin_security_alerts if @security_alert.save
  end

  def new
  	@security_alert = SecurityAlert.new
  end

  def edit
  	@security_alert = SecurityAlert.find(params[:id])
  end

  def show
  	@security_alert =  SecurityAlert.find(params[:id])
  	respond_to do |format|
      format.js
    end
  end

  private

  def security_alert_params
  	params.require(:security_alert).permit(:title, :description, :severity, :link)
  end

end
