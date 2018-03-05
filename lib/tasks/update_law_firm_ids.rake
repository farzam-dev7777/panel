namespace :my_namespace do
  task :set_law_firm_ids => :environment do
  	User.all.each do |user|
  		if user.law_firm
	  		user.law_firm_id = user.law_firm.id
	  		user.role = 'master_user'
	  		user.save!
	  		puts "user #{user.id} updated"
	  	end
  	end
  end
end