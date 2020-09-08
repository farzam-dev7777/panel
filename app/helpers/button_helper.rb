module ButtonHelper
	
  def certification_status(law_firm)
    return unless law_firm
    submissions = law_firm.try(:form_submissions)

    if (submissions.any?)
      # return "" if submissions.latest.status == "approved"
      if (submissions.latest.submitted)
        if submissions.latest.total_score && submissions.latest.status == 'approved'
          gauge(submissions.latest)
        # elsif(submissions.latest.status == 'decline')
        #   link_to 'Your submission has been declined', '#', html_options = {class: 'btn-type-primary dashboard-certificate-button text-center', disabled: true}  
        elsif submissions.latest.submitted
          link_to 'Your submission is being reviewed', '#', html_options = {class: 'btn-type-primary dashboard-certificate-button text-center', disabled: true}  
        elsif submissions.latest.status == 'started'
          link_to 'Continue RFI Process', pricing_step_form_submission_path(submissions.latest), html_options = {class: 'btn-type-primary dashboard-certificate-button'}  
        
        end
      elsif(submissions.latest.status == 'sent')
        link_to 'Begin RFI Process', pricing_step_form_submission_path(submissions.latest), html_options = {class: 'btn-type-primary dashboard-certificate-button'}
      elsif(submissions.latest.status == 'started')
        link_to 'Continue RFI Process', pricing_step_form_submission_path(submissions.latest), html_options = {class: 'btn-type-primary dashboard-certificate-button'}
      elsif(submissions.latest.status == 'follow_up')
        link_to 'Answer Follow Ups ' + "(#{submissions.latest.follow_ups.review.count})", pricing_step_form_submission_path(submissions.latest), html_options = {class: 'btn-type-primary dashboard-certificate-button'}
      end
    else
      '<p class="not-available">Panel status is not available yet</p>'.html_safe
    end
  end

  def gauge(submission)
    status = submission.status.try(:humanize)
    if status == "Approved"
      "<div class='btn-primary btn-certified'>Certified</div>".html_safe
    else
      "
        <h3 class='firm-score-#{submission.status}'>
          <span>#{status}</span>
        </h3>
      ".html_safe
    end
    # "
    #   <h3 class='firm-score-#{submission.status}'>
    #     <span>#{status}</span>
    #   </h3>
    #   <div id='law-firm-rating' class='force-center'></div> 
    #   (#{submission.law_firm.total_calculated_score.try(:to_s)})
    # ".html_safe
  end

end
