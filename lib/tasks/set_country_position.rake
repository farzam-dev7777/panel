namespace :set_country_position do
  task :update_country_position => :environment do
		Country.where(id: [71]).update_all(position: 1)
		Country.where(id: [266]).update_all(position: 2)
		Country.where.not(id: [71,266]).update_all(position: 9)
  end
end