class ServiceResponse
  attr_accessor :success, :object, :reason, :details, :errors

  def initialize(object, success=true, reason=nil, details=nil)
    @object = object
    @reason = reason
    @details = details

    if @object.respond_to? :errors
      @success = @object.errors.none? && success
    else
      @success = success
    end
    @errors = []
  end

  def success?
    @success
  end

  def fail?
    !@success
  end
  alias_method :failure?, :fail?

  def fail!
    @success = false
  end

  def details
    return @details if @details.present?
    @errors.map(&:message).join("\n")
  end

  def add_error_code(e)
    @errors << ServiceError.new(e)
  end

  def self.failure(object)
    ServiceResponse.new(object, false)
  end

  def self.with_errors(object, errs)
    response = ServiceResponse.new(object, false)
    Array.wrap(errs).each { |e| response.add_error_code(e) }
    response
  end

  def self.success(object = nil)
    ServiceResponse.new(object)
  end

  def has_error?(code)
    error_codes.include?(code)
  end

  def error_codes
    @errors.map {|err| err.code }
  end
end
