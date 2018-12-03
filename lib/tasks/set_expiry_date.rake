# rake law_firms:set_expiry_date
namespace :law_firms do
  desc "TODO"
  task set_expiry_date: :environment do
  	LawFirm.all.each do |law_firm|
  		latest_form_submission = law_firm.form_submissions.latest
  		latest_form_submission.expiry_date = Time.now + 1.year if latest_form_submission.try(:status) == 'approved'
  	end
  end
end
