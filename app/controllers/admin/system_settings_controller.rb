class Admin::SystemSettingsController < Admin::BaseController

	layout 'admin'

  before_action :find_system_settings, only: [:index, :update, :edit]

  def index
  end

  def update
  	if @settings.update_attributes(settings_params)
  		redirect_to :back, notice: "System Settings Saved"
    else
      redirect_to :back, notice: "Couldn't save system settings"
  	end
  end

  def edit
  end

  def show
  end

  private

  def find_system_settings
    @settings = SystemSetting.last || SystemSetting.create
  end

  def settings_params
  	params.require(:system_setting).permit(:score_threshold)
  end

end
