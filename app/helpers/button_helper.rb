module ButtonHelper
	
  def certification_status(law_firm)
    submissions = law_firm.form_submissions
    if (submissions.any?)
      if (submissions.last.submitted)
        submissions.last.score ? gauge : ''
      else
        link_to 'Continue Certification Process', policy_step_form_submission_path(submissions.last), html_options = {class: 'btn btn-primary'}
      end
    else
      link_to 'Start Certification Process', new_form_submission_path, html_options = {class: 'btn btn-primary'}
    end
  end

  def gauge
    '<div id="gauge"></div>'.html_safe
  end

  def certification_process_btn(title)
    '<a href="" class="btn btn-primary">' + title + '</a>'.html_safe
  end

end
