class EmailField < FormField

  def as
    :email
  end

  def add_validation_errors(value); end
end