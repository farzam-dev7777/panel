class FormSubmissionDecorator < Draper::Decorator
  delegate_all

  def status
    if (object.follow_ups.map(&:status).count('pending') > 0)
      'Under Review'
    elsif (object.follow_ups.map(&:status).count('review') > 0)
      'Requested Follow Up'
    elsif (object.submitted && object.submited_on)
      'Submitted'
    else
      'Not Submitted'
    end
  end

end