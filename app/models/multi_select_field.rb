class MultiSelectField < FormField
  
  def as
    :select
  end

  def collection
    self.dropdown_options.map{|dropdown_option| [dropdown_option.key, dropdown_option.value]}
  end

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