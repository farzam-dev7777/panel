class ProposalsController < BaseController

	def index
		@proposals = current_user.law_firm.proposals
	end

	def new
		@rfp = Rfp.find_by_id params[:rfp_id]
		@proposal = @rfp.proposals.new
		@rfp.questions.each do |question|
			@proposal.answers.build(rfp_id: @rfp.id, question_id: question.id)
		end
	end

	def edit
		@proposal = Proposal.find params[:id]
		@rfp = @proposal.rfp
	end

	def create
		@rfp = Rfp.find_by_id params[:rfp_id]
		if @rfp.expiry_date.present? && @rfp.expiry_date < Date.today
			flash[:alert] = "Proposal can't submit after expiry date" 
			redirect_to root_path()
		else
		  	@proposal = @rfp.proposals.new(proprosal_params)
		  	@proposal.law_firm_id = current_user.law_firm.id
		  	@proposal.created_by_id = current_user.id
		  	@proposal.updated_by_id = current_user.id
		  	@proposal.status = 'pending'
		  	if @proposal.save
		      flash[:notice] = "Proposal submitted"
		      redirect_to root_path()
		  	else
		      flash[:alert] = "There was an error initiating proposal request. #{@proposal.errors.full_messages.join(', ')}" 
		      render :new
		  	end
		end
	end

	def update
		@proposal = Proposal.find_by_id(params[:id])
		@rfp = @proposal.rfp
		if @rfp.expiry_date.present? && @rfp.expiry_date < Date.today
			flash[:alert] = "Proposal can't update after expiry date" 
			redirect_to root_path()
		else
		  	if @proposal.update(proprosal_params.merge(updated_by_id: current_user.id))
		      flash[:notice] = "Proposal updated"
		      redirect_to root_path()
		  	else
		      flash[:alert] = "There was an error initiating proposal request. #{@proposal.errors.full_messages.join(', ')}" 
		      render :edit
		  	end
	  	end
	end

	def add_comment
		@proposal = Proposal.find_by_id(params[:id])
		@proposal.proposal_comments.create(user_id: current_user.id, message: params[:comment])
		redirect_back fallback_location: root_path
	end

	def show
		@proposal = Proposal.find params[:id]
	end

	def proprosal_params
		params.require(:proposal).permit(
			:amount, :description, :rfp_id, :updated_by,
			answers_attributes: [:id, :response, :date, :file, :rfp_id, :question_id],
		)
	end
end