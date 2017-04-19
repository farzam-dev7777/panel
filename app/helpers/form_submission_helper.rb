module FormSubmissionHelper

  def note_class(type)
    case type
    when 'technology'
      'note-technology'
    when 'history'
      'col-md-1 note-history'
    end
  end

  def follow_up_class(form_submission_id, loggable_id, loggable_type)
    follow_up = find_follow_up(filter(form_submission_id: form_submission_id, 
                                      loggable_id: loggable_id, 
                                      loggable_type: loggable_type))
    if follow_up
      case follow_up.status
      when 'pending'
        'need-follow-up'
      when 'review'
        'need-follow-up'
      when 'resolved'
        'follow-up-success'
      end
    end
  end

  def policy_step_instructions

  end

  def follow_up_class_for_law_firm(loggable_id, loggable_type, form_submission_id)
    follow_up = find_follow_up(filter(loggable_id: loggable_id, 
                                      loggable_type: loggable_type,
                                      form_submission_id: form_submission_id))
    if follow_up
      if (follow_up.status == 'review')
        'need-follow-up'
      elsif (follow_up.status == 'resolved')
        'follow-up-success'
      end
    end
  end

  def follow_up_needed?(form_submission_id, loggable_id, loggable_type)
    find_follow_up(filter(form_submission_id: form_submission_id, 
                          loggable_id: loggable_id, 
                          loggable_type: loggable_type)) ? true : false
  end

  def save_and_follow_up?(form_submission_id)
    FollowUp.where(form_submission_id: form_submission_id).map(&:status).count('pending') > 0
  end

  def submission_status_class(submission)
    if (submission.status == 'approved')
      'success'
    elsif (submission.status == 'declined')
      'danger'
    else
      'info'
    end
          
    # if (submission.follow_ups.map(&:status).count('pending') > 0)
    #   'warning'
    # elsif (submission.follow_ups.map(&:status).count('review') > 0)
    #   'info'
    # elsif (submission.submitted && submission.submitted_on)
    #   'success'
    # else
    #   'default'
    # end
  end

  def find_follow_up(filters)
    FollowUp.find_by(filters)
  end

  def is_technical_threat(technology_value)
    security_threats = SecurityThreat.where(vendor: technology_value.vendor, 
                                            platform: technology_value.platform, 
                                            version: technology_value.version, 
                                            service_pack: technology_value.service_pack)
    security_threats.count > 0 ? "threat-found #{security_threats.count}-threat(s)-found" : "hidden"
  end

  def filter(form_submission_id: nil, loggable_id: nil, loggable_type: nil, status: nil)
    filter = {}
    filter[:form_submission_id] = form_submission_id if form_submission_id
    filter[:loggable_id] = loggable_id if loggable_id
    filter[:loggable_type] = loggable_type if loggable_type
    filter[:status] = status if status
    filter
  end

end
