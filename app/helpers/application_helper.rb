module ApplicationHelper
  def get_form_value_class(sub_fields, group_form)
    if !group_form && !sub_fields
      'col-md-12 form_value_class'
    elsif !group_form && sub_fields
      'col-md-offset-2 col-md-10 form_value_class'
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
    scope.size == 0 ? [] : scope
  end

  def ajax_redirect_to(redirect_uri)
    { js: "window.location.replace('#{redirect_uri}');" }
  end

  def render_security_threat_link(action_item)
    "<a data-toggle='modal' data-target='securityThreat' data-remote='true' href='/action_items/#{action_item.id}'>Security Threat</a>"
  end

  def activity_source(activity)
    return "<i class='fa fa-question log-icon' data-original-title='Source not available'></i>".html_safe unless activity.source
    user = activity.source.constantize.find_by(email: activity.email)
    if(user.class.to_s == 'User')
      source = activity.source.constantize.find_by(email: activity.email).try(:law_firm).try(:name)
      "<i class='fa fa-university log-icon law-firm' data-toggle='tooltip' data-original-title='#{source}' title='#{source}'></i>".html_safe
    elsif(user.class.to_s == 'AdminUser')
      source = 'Admin'
      "<i class='fa fa-shield log-icon admin' data-toggle='tooltip' data-original-title='#{source}' title='#{source}'></i>".html_safe
    end
  end

  def activity_source_class(activity)
    return nil unless activity.source
    user = activity.source.constantize.find_by(email: activity.email)
    if(user.class.to_s == 'User')
      'lawfirm-activity-color'
    elsif(user.class.to_s == 'AdminUser')
      'lawfirm-bank-color'
    end
  end

end
