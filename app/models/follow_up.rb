class FollowUp < ApplicationRecord
	belongs_to :loggable, polymorphic: true

	has_many :notes

	scope :pending,  		-> { where(status: 'pending') }
	scope :review,  		-> { where(status: 'review') }
	scope :resolved,  	-> { where(status: 'resolved') }

	scope :policy,  		-> { where(loggable_type: FormValue) }
	scope :process,  		-> { where(loggable_type: FormValue) }
	scope :technology,  -> { where(loggable_type: TechnologyValue) }
	scope :history,  		-> { where(loggable_type: HistorySubmission) }

	def add_note(message, step, sender)
		note = Note.new_note(self, message, step, sender)
		note
	end

  def form_field_id
    self.loggable.try(:form_field_id)
  end

end
