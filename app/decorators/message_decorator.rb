class MessageDecorator < Draper::Decorator

  delegate_all

  def humanized_created_at
    if object.created_at >= Time.now - 24.hours
      object.created_at.strftime("%I:%M%P")
    elsif object.created_at >= Time.now - 365.days && object.created_at < Time.now - 24.hours 
      object.created_at.strftime("%b %e")
    end
  end

end