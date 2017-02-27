class TechnologyDecorator < Draper::Decorator
  delegate_all

  def vendor
    object.vendor
  end

  def platform
  	object.platform
  end

  def version
  	object.version
  end

  def service_pack
  	object.service_pack
  end

end