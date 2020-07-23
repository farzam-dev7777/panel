namespace :set_country_position do
  task :update_country_position => :environment do
		Country.where(country_id: [38]).update_all(position: 1)
		Country.where(country_id: [233]).update_all(position: 2)
		Country.where.not(country_id: [38,233]).update_all(position: 9)
  end
end