class Admin::SystemSettingsController < Admin::BaseController

	layout 'admin'

  before_action :find_system_settings, only: [:index, :update, :edit]

  def index
  end

  def update
    if @settings.update(settings_params)
      if request.xhr?
        render json: :ok
      else
        redirect_back fallback_location: admin_root_path, notice: "Settings saved"
      end
    else
      redirect_back fallback_location: admin_root_path, alert: "Settings NOT saved"
    end
  end

  def edit
    authorize! :edit, @settings
  end

  def show
  end

  private

  def find_system_settings
    @severity_levels = SeverityLevel.all
    @settings = SystemSetting.fetch
  end

  def settings_params
  	params.require(:system_setting).permit(:score_threshold, :docusign_access_token, :lxp_name, :lxp_email, :panel_status)
  end

end
