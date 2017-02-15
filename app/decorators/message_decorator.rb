class MessageDecorator < Draper::Decorator

  include ActionView::Helpers::TextHelper
  delegate_all

  def humanized_created_at
    if object.created_at >= Time.now - 24.hours
      object.created_at.strftime("%I:%M%P")
    elsif object.created_at >= Time.now - 365.days && object.created_at < Time.now - 24.hours 
      object.created_at.strftime("%b %e")
    end
  end

  def body_excerpt
    truncate(object.body, length: 70)
  end

end