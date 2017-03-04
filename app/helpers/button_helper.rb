module ButtonHelper
	
  def certification_status(law_firm)
    submissions = law_firm.form_submissions
    if (submissions.any?)
      if (submissions.last.submitted)
        if submissions.last.score
          gauge(submissions.last)
        elsif submissions.last.submitted
          'Your submission is being reviewed.'
        elsif submissions.last.follow_ups.map(&:status).count('review') > 0
          link_to 'Continue Certification Process', policy_step_form_submission_path(submissions.last), html_options = {class: 'btn btn-primary btn-lg dashboard-certificate-button'}  
        end
      else
        link_to 'Continue Certification Process', policy_step_form_submission_path(submissions.last), html_options = {class: 'btn btn-primary btn-lg dashboard-certificate-button'}
      end
    else
      link_to 'Start Certification Process', new_form_submission_path, html_options = {class: 'btn btn-primary btn-lg dashboard-certificate-button'}
    end
  end

  def gauge(submission)

    '<div class="col-md-12">
      <article class="col-sm-12">
        <div class="jarviswidget">
            <header>
              <span class="widget-icon"> <i class="fa fa-bar-chart"></i> </span>
              <h2><strong>SEAL</strong> Score </h2>
            </header>
            <div class="no-padding">
              <div class="widget-body">
                <div id="myTabContent" class="tab-content">
                  <div class="tab-pane fade active in padding-10 no-padding-bottom" id="s1">
                    <div class="row no-space text-center">
                      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div id="gauge"></div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </article>
      </div>'.html_safe

    "<script>
      var g = new JustGage({
        id: 'gauge',
        value: #{submission.score},
        min: 0,
        max: 300
      });
    </script>".html_safe
  end

end
