class Admin::SystemSettingsController < Admin::BaseController

	layout 'admin'

  def index
  	@settings = SystemSetting.last
  end

  def update
  	@settings = SystemSetting.last
  	if @settings.update_attributes(settings_params)
  		redirect_to edit_admin_system_setting_path && return
  	end
  end

  def edit
  	@settings = SystemSetting.last
  end

  private

  def settings_params
  	params.require(:system_setting).permit(:score_threshold)
  end

end
