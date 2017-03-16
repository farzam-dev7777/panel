class Admin::SystemSettingsController < Admin::BaseController

	layout 'admin'

  def index
  	@settings = SystemSetting.last
  end

end
