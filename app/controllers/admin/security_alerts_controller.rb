class Admin::SecurityAlertsController < Admin::BaseController

  layout 'admin'
	skip_before_action :authenticate_user!, only: [:show]

  def index
  	@q = SecurityAlert.ransack(params[:q])
    @security_alerts = @q.result(distinct: true).paginate(page: params[:page])
  end

  def create
    @security_alert = SecurityAlert.new(security_alert_params)
    redirect_to :admin_security_alerts if @security_alert.save
  end

  def update
    @security_alert = SecurityAlert.find(params[:id])
    if @security_alert.update(security_alert_params)
      redirect_to :admin_security_alerts if @security_alert.save
    else
      render :edit, alert: @security_alert.errors.full_messages.join(', ')
    end
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

  def destroy
  	@security_alert =  SecurityAlert.find(params[:id])
    alert_msg = ""
    if @security_alert 
      @security_alert.destroy
      alert_msg = "Security alert has been successfully deleted"
    else
      alert_msg = "We couldn't find the security alert in our database."
    end
    redirect_to admin_security_alerts_path, alert: alert_msg
  end

  private

  def security_alert_params
  	params.require(:security_alert).permit(:title, :description, :severity, :link)
  end

end
