class FollowUp < ApplicationRecord
	belongs_to :loggable, polymorphic: true

	has_many :notes

	scope :pending,  		-> { where(status: 'pending') }
	scope :review,  		-> { where(status: 'review') }
	scope :resolved,  	-> { where(status: 'resolved') }

	scope :pricing,  		  -> { where(loggable_type: FormValue) }
	scope :relationship,  -> { where(loggable_type: FormValue) }
	scope :diversity,   	-> { where(loggable_type: FormValue) }
	scope :innovation,    -> { where(loggable_type: FormValue) }
	scope :resourcing,  	-> { where(loggable_type: FormValue) }

	def add_note(message, step, sender)
		note = Note.new_note(self, message, step, sender)
		note
	end

  def form_field_id
    self.loggable.try(:form_field_id)
  end

end
