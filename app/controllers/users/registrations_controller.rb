class Users::RegistrationsController < Devise::RegistrationsController

	def update
		# binding.pry
		if current_user && (params[:user][:password] == params[:user][:password_confirmation])
			current_user.password = params[:user][:password]
			if current_user.save
				bypass_sign_in(current_user) 
				redirect_to root_url, notice: 'Your password has been changed'
			end
		else
			flash[:alert] = 'Both passwords should match'
			render :edit
		end
	end

end
