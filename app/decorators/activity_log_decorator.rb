class ActivityLogDecorator < Draper::Decorator
  delegate_all

  def custom_message
    object.custom_message
  end

  def event_type
  	object.event_type
  end

  def created_at
  	object.created_at
  end

end