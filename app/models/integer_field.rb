class IntegerField < FormField

  def add_validation_errors(value)
    # unless value.blank? || value.match(/\A[+-]?\d+\Z/)
    #   form_value.errors.add :value, 'must be an integer'
    # end

    # int_value = value.to_i
    # if max.present? && int_value > max.to_i
    #   form_value.errors.add :value, "can't be greater than #{max}"
    # end

    # return unless min.present? && int_value < min.to_i

    # form_value.errors.add :value, "can't be less than #{min}"
  end
  
end