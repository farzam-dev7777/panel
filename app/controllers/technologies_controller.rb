class TechnologiesController < BaseController

	skip_before_filter :authenticate_user!, only: [:index]

	def index
		@technologies = []

		# if technology_filter_params[:vendor]
			@technologies = Technology.select(params[:field].to_s).where(technology_filter_params).uniq
		# end
		render json: @technologies.map{ |technology| { id: technology.send(params[:field]), text: technology.send(params[:field]) } }
	end

	private

	def technology_filter_params
		params.require(:filter).permit(:vendor, :platform, :version, :service_pack, :platform_category, :platform_type).reject { |key,value| value.empty? }
	end

end
