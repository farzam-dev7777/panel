class TechnologyValuesController < BaseController

  def create
  end

  def new
  	@technology = TechnologyValue.new
  end

  def import
  end

  private

  def find_law_firm
  	@law_firm = LawFirm.find_by(id: params[:id])
  end

  def build_params
    params.require(:technology).permit(technologies_attributes: [:id, :platform_category, :platform_type, :vendor, :platform, :version, :service_pack, :supported, :_destroy])
  end

end
