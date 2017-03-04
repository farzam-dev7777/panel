class NoteDecorator < Draper::Decorator
  delegate_all

  def created_at
  	h.time_ago_in_words(object.created_at)
  end

end