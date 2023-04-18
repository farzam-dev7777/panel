namespace :law_firms do
  desc "Law Firm Report"
  task report: :environment do
    rows = []
    LawFirm.all.map do |lf|
      cols = []
      cols << lf.name
      cols << lf.number_of_lawyers
      cols << lf.type_of_matters_your_law_firm_handles_for_us.reject(&:blank?).join("|")
      cols << lf.users.count;nil
      cols << lf.users.where(role: "master_user").first&.username;nil
      cols << lf.created_at
      form_submission = lf.form_submissions.last
      cols << form_submission&.submitted_on
      cols << form_submission&.system_score
      cols << form_submission&.assessor_score
      cols << lf.responsiveness_rate
      cols << form_submission&.total_score
      rows << cols.join(", ")
    end;nil
    puts "Name, Number of employees, Type of matter, User count, Master user ID, Date of invitation, Date of submission, System score, Assessor score, Responsive score, Total score"
    puts rows

  end

end
