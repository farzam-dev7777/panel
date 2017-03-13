class ActionItemDecorator < Draper::Decorator
  delegate_all

  def security_threat
  	object.security_threat
  end

end