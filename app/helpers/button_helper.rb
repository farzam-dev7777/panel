module ButtonHelper
	
  def certification_status(law_firm)
    submissions = law_firm.form_submissions

    if (submissions.any?)
      # return "" if submissions.latest.status == "approved"
      if (submissions.latest.submitted)
        if submissions.latest.total_score && submissions.latest.status == 'approved'
          gauge(submissions.latest)
        elsif(submissions.latest.status == 'decline')
          link_to 'Your submission has been declined', '#', html_options = {class: 'btn btn-danger btn-lg dashboard-certificate-button text-center', disabled: true}  
        elsif submissions.latest.submitted
          link_to 'Your submission is being reviewed', '#', html_options = {class: 'btn btn-primary btn-lg dashboard-certificate-button text-center', disabled: true}  
        elsif submissions.latest.status == 'started'
          link_to 'Continue Certification Process', policy_step_form_submission_path(submissions.latest), html_options = {class: 'btn btn-primary btn-lg dashboard-certificate-button'}  
        
        end
      elsif(submissions.latest.status == 'sent')
        link_to 'Begin Certification', policy_step_form_submission_path(submissions.latest), html_options = {class: 'btn btn-primary btn-lg dashboard-certificate-button'}
      elsif(submissions.latest.status == 'started')
        link_to 'Continue Certification Process', policy_step_form_submission_path(submissions.latest), html_options = {class: 'btn btn-primary btn-lg dashboard-certificate-button'}
      elsif(submissions.latest.status == 'follow_up')
        link_to 'Answer Follow Ups ' + "(#{submissions.latest.follow_ups.review.count})", policy_step_form_submission_path(submissions.latest), html_options = {class: 'btn btn-primary btn-lg dashboard-certificate-button'}
      end
    end
  end

  def gauge(submission)
    '<div id="law-firm-rating" class="force-center"></div>'.html_safe
    submission.status.try(:humanize) + ' (' + submission.total_score.try(:to_s)
  end

end
