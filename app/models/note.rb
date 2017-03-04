class Note < ApplicationRecord

	def self.new_note(follow_up, message, step, sender)
  	submission = FormSubmission.find_by(id: follow_up.form_submission_id)
  	
  	@note = Note.new
    @note.follow_up_id = follow_up.id
  	@note.message_type = 'request_information' 
  	@note.message = message 
  	@note.step = step
  	@note.sender = sender
  	if(@note.save)
  		@note
  	end
	end

end
