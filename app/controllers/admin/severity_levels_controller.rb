class Admin::SeverityLevelsController < Admin::BaseController

	before_filter :find_severity_level, only: [:update]

  def new
  	@severity_levels = SeverityLevel.new
  end

  def update
  	@severity_level.update(build_params)
    redirect_to :back
  end

  private

  def find_severity_level
  	@severity_level = SeverityLevel.find_by(id: params[:id])
  end

  def build_params
    params.require(:severity_level).permit(:name, triggers_attributes: [:id, :hours, :message, :action_type, :_destroy])
  end

end