class Admin::NotesController < Admin::BaseController

  def create
  	step = Rails.application.routes.recognize_path(request.referrer)[:action]
  	submission = FormSubmission.find_by(id: params[:form_submission_id])
  	@note = Note.new(note_params)
  	@note.step = step
  	@note.law_firm_id = submission.law_firm_id
  	@note.admin_user_id = current_admin_user.id
  	@note.sender = 'admin'
  	if(@note.save)
  		render json: @note.to_json
  	end
  end

  def destroy
    note = Note.find_by(id: params[:id])
    if note && note.sender == current_user.email
      note.update(deleted_at: Time.now)
      head :ok
    else
      render :json => { errors: "You're not authorized to delete this note" }
    end
  end

  private

  def note_params
  	params.permit(:form_submission_id, :message_type, :message)
  end

end
