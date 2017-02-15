class MessageDecorator < Draper::Decorator

  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::TagHelper

  delegate_all

  def humanized_created_at
    if object.created_at >= Time.now - 24.hours
      object.created_at.strftime("%I:%M%P")
    elsif object.created_at >= Time.now - 365.days && object.created_at < Time.now - 24.hours 
      object.created_at.strftime("%b %e")
    end
  end

  def subject_line
    subject = content_tag(:span, object.subject)
    body = object.body
    subject_line = "#{subject.html_safe} #{body}"
    truncate(subject_line.html_safe, length: 110)
  end

end