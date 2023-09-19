module ApplicationHelper

  def rescued_csrf_meta_tags
    csrf_meta_tags
  rescue ArgumentError
    request.reset_session
    csrf_meta_tags
  end

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
    scope.size == 0 ? TechnologyValue.new(platform_category: platform_category, platform_type: type) : scope
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

  def activity_icon(event_type)
    case event_type
    when 'account_created'
      "fa-user-plus"
    when 'todo_task_created'
      "fa-list-ul"
    when 'information_security_policy_request_initiated'
      "fa-shield"
    when 'seal_certification_process_initiated'
      "fa-shield"
    when 'information_security_policy_submitted'
      "fa-paper-plane"
    when 'information_security_policy_review_started'
      "fa-search"
    when 'follow_up'
      "fa-share-square-o"
    when 'approved'
      "fa-thumbs-up"
    when 'declined'
      "fa-thumbs-down"
    when 'critical_security_alert'
      "fa-exclamation-triangle"
    when 'high_security_alert'
      "fa-exclamation-triangle"
    when 'low_security_alert'
      "fa-exclamation-triangle"
    when 'decertify'

    when 'recertification_process_initiated'
      "fa-shield"
    when 'decrease_score'
      "fa-arrow-down"
    when 'action_item_marked_as_complete'
      "fa-check-circle"
    when 'login'
      "fa-sign-in"
    when 'logout'
      "fa-sign-out"
    when 'expiry_date_changed'
      "fa-calendar"
    when 'technologies_updated'
      "fa-laptop"
    when 'history_updated'
      "fa-history"
    else
      "fa-edit"
    end
  end

  def active_menu_item(path)
    current_page?(path) ? 'active' : ''
  end

  def active_page?(current_page)
		return unless request.path.include?(current_page.to_s)

		'active'
	end

  def get_avatar_image(name, background_color = nil, color = nil)
    if background_color.blank?
      color_samples = ["F13838", "4D00CA", "00a0af", "00B2CA", "4C82FF", "FFB800"]
      if !name.nil?
        characters = ("a".."z").to_a
        character_index = characters.find_index(name.first.downcase)
        selected_color_index = character_index ? ((character_index/characters.length.to_f) * color_samples.length).to_i : 1
      else
        selected_color_index = 0
      end
      background_color = color_samples[selected_color_index]
    end

    if color.blank?
      color = "FFF"
    end
    "https://ui-avatars.com/api/?name=#{name}&background=#{background_color}&color=#{color}"
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.simple_fields_for(association, association.to_s.singularize.capitalize.constantize.new, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", form: builder)
    end
  end

  def can_access_matter_field(field_name)
    ['w','rw'].include?(MatterIntake::MATTER_FORM[current_user.role.to_sym][field_name.to_sym][:access])
  end

  def can_read_access_matter_field(field_name)
    ['r','rw'].include?(MatterIntake::MATTER_FORM[current_user.role.to_sym][field_name.to_sym][:access])
  end

  def matter_url
    if current_user.role == 'lob'
      "/lob/matter_intakes"
    elsif current_user.role == 'lxp' || current_user.role == 'internal_lawyers'
      "/admin/matter_intakes"
    else
      "/matter_intakes"
    end
  end

  def matter_form_url(matter_intake)
    if current_user.role == 'lob'
      [:lob, matter_intake]
    elsif current_user.role == 'lxp'
      [:admin, matter_intake]
    else
      [matter_intake]
    end
  end

  def law_firm_form_url(law_firm)
    if current_user.role == 'lob'
      [:lob, law_firm]
    elsif current_user.role == 'lxp'
      [:admin, law_firm]
    else
      [law_firm]
    end
  end

  def matter_lang_title(attr_id, default_label)
    if I18n.locale == :en
      I18n.backend.send(:translations)[:fr][attr_id]||default_label
    else
      I18n.backend.send(:translations)[:en][attr_id]||default_label
    end
  end

end
