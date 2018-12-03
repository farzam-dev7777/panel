class TechnologiesController < BaseController

	skip_before_filter :authenticate_user!, only: [:index]

	def index
		@technologies = []
		@technologies = Technology.select(params[:field].to_s).where(technology_filter_params).uniq
		render json: @technologies.map{ |technology| { id: technology.send(params[:field]), text: technology.send(params[:field]) } }
	end

	private

	def technology_filter_params
		params.require(:filter).permit(:vendor, :platform, :version, :service_pack, :platform_category, :platform_type).reject { |key,value| value.empty? }
	end

end
