class Admin::SecurityThreatsController < Admin::BaseController

  layout 'admin'

  def index
  	@security_threats = SecurityThreat.all.paginate(page: params[:page])
  end

  def new
  	@security_threat = SecurityThreat.new
    @triggers = []
  end

  def create
    @security_threat = SecurityThreat.new(security_threat_params)
    if (@security_threat.save)
    	@security_threat.generate_action_items(params, current_admin_user)
    end
    redirect_to admin_security_threats_path
  end

  def find_law_firms
		form_submission_ids = TechnologyValue.select(params[:field].to_s).where(technology_values_filter_params).uniq.pluck(:form_submission_id)
		law_firms = LawFirm.joins(:form_submissions).where("form_submissions.id IN (?)", form_submission_ids)

		render json: law_firms.map{ |firm| { id: firm.id, text: firm.name } }
	end

  def show
    @security_threat = SecurityThreat.find_by(id: params[:id])
    @action_items = @security_threat.action_items
    respond_to do |format|
      format.js
    end
  end

  def severity_negative_factors_for_triggers
    triggers = SeverityLevel.find_by(id: params[:id]).try(:triggers)
    render partial: 'severity_negative_factor', locals: { triggers: triggers }
  end

  private

  def security_threat_params
  	params.require(:security_threat).permit(:title, :description, :severity_level_id, law_firm_ids: [], technology: [], severity_negative_factor: [])
  end

  def technology_values_filter_params
		params.require(:filter).permit(:vendor, :platform, :version, :service_pack).reject { |key,value| value.empty? }
	end

end
