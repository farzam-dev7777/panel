class DateField < FormField

  def parse_date(form_value)
    Date.strptime(form_value.value, "%d-%m-%Y") if form_value.value && !form_value.value.blank?
  end

  def add_validation_errors(form_value)
    # return 
    # return if form_value.value.blank?

    # unless valid_date?(form_value)
    #   form_value.errors.add :value, 'must be a valid date'
    #   return
    # end

    # date = parse_date(form_value)
    # if min.present?
    #   min_date = Date.parse(min)
    #   form_value.errors.add :value, "can't be before #{min_date}" if date < min_date
    # end
    # if max.present?
    #   max_date = Date.parse(max)
    #   form_value.errors.add :value, "can't be after #{max_date}" if date > max_date
    # end
  end

  private

  def valid_date?(form_value)
    begin
      parse_date(form_value)
    rescue
      return false
    end
  end

end