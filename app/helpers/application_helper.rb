module ApplicationHelper
  def get_form_value_class(sub_fields, group_form)
    if !group_form && !sub_fields
      'col-md-12 form_value_class'
    elsif !group_form && sub_fields
      'col-md-offset-4 col-md-8 form_value_class'
    elsif group_form && !sub_fields
      'col-md-12 form_value_class no-padding'
    end
  end

  def get_form_value_field_class(sub_fields, group_form, form_values)
    col_width = 12 / form_values.count
    !sub_fields && group_form ? "col-md-#{col_width} form_value_field_class" : ""
  end

  def get_form_value_field_wrapper_class(sub_fields, group_form, form_values, index)
    !sub_fields && group_form && index == 0 ? 'row form_value_field_wrapper_class' : ''
  end

  def show_when_field_id(form_value)
    form_value.form_field.show_when_form_field_id
  end

  def show_when_value(form_value)
    form_value.form_field.show_when_form_field_value
  end

  def custom_logic(form_value)
    form_value.form_field.custom_logic
  end

  def admin_panel?
    params[:controller].include?('admin')
  end

  def build_fields(form_submission, scope, platform_category, type)
    scope.size == 0 ? form_submission.technology_values.build(platform_category: platform_category, platform_type: type) : scope
  end

end
