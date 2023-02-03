namespace :update do
	desc "Update tenant_id to all existing users"
  task :tenant_id => :environment do
		puts "##### Staring updating tenant on user"
		tenant = Tenant.find_by(subdomain: 'cwb')
		User.find_each do |user|
			if user.tenant_id.nil?
				if user.update(tenant_id: tenant.id)
					puts "Tenant updated on user with user id: #{user.id} with first_name: #{user.first_name}"
				else
					puts "!!!Failed to update tenant on user with user id: #{user.id} with first_name: #{user.first_name}"
				end
			else
				puts "Tenant already updated on user with id: #{user.id} and first_name: #{user.first_name}"
			end
		end
		puts "##### Finishing updating tenant on user"
	end
end