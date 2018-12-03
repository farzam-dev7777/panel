class Admin::SystemSettingsController < Admin::BaseController

	layout 'admin'

  before_action :find_system_settings, only: [:index, :update, :edit]

  def index
  end

  def update
  	@settings.update_attributes(settings_params)
		render json: :ok
  end

  def edit
    authorize! :edit, @settings
  end

  def show
  end

  private

  def find_system_settings
    @severity_levels = SeverityLevel.all
    @settings = SystemSetting.last || SystemSetting.create
  end

  def settings_params
  	params.require(:system_setting).permit(:score_threshold)
  end

end
