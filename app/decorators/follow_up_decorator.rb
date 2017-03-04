class FollowUpDecorator < Draper::Decorator
  delegate_all

  def messages
  	object.notes.map{|note| note.decorate }
  end

end