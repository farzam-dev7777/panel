class Admin::FollowUpsController < Admin::BaseController

	before_action :find_follow_up, only: [:create, :resolve, :reviewed]
	skip_before_filter :authenticate_admin_admin_user!, only: [:create]

	def create
		username = current_admin_admin_user.try(:email) || current_user.try(:username)
		if (@follow_up)
			@note = @follow_up.add_note(params[:message], current_step, username)
		else
			@follow_up = FollowUp.new
			@follow_up.form_submission_id = params[:form_submission_id]
			@follow_up.loggable_type = params[:loggable_type].constantize
			@follow_up.loggable_id = params[:loggable_id]
			@follow_up.status = 'pending'
			if (@follow_up.save)
				@note = @follow_up.add_note(params[:message], current_step, username)
			end
		end

		render partial: 'follow_up_note', locals: {message: @note.decorate}, layout: false
	end

	def resolve
		@follow_up = FollowUp.find(params[:follow_up_id])
		if @follow_up
			@follow_up.update_attributes(status: 'resolved')
			head :ok
		end
	end

	def review
		if @follow_up
			@follow_up.update_attributes(status: 'review')
		end
	end

	private

	def find_follow_up
		@follow_up = FollowUp.find_by(form_submission_id: params[:form_submission_id], 
																	loggable_id: params[:loggable_id],
																	loggable_type: params[:loggable_type])
	end

	def current_step
		Rails.application.routes.recognize_path(request.referrer)[:action]
	end

end
