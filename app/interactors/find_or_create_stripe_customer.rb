class FindOrCreateStripeCustomer
	include Interactor

	before :verify_execution
	#	params: {
	#		name: String
	#		email: String
	#		phone: String
	#		address: String
	# }
	def call
		stripe_customers = Stripe::Customer.list({email: context.params[:email]})
		if stripe_customers&.data.present? && stripe_customers&.data&.count > 0
			context.stripe_customer = stripe_customers&.data&.first
		else
			# Stripe customer not found
			create_stripe_customer
		end
	end

	def verify_execution
		if context.params[:name].blank?
			context.fail!(errors: ["Company name must be specify"])
		end

		if context.params[:email].blank?
			context.fail!(errors: ["Company email must be specify"])
		end

		context.params[:email] = context.params[:email]&.downcase

		if context.params[:phone].blank?
			context.fail!(errors: ["Company phone must be specify"])
		end

		if context.params[:address].blank?
			context.fail!(errors: ["Company address must be specify"])
		end
	end

	def create_stripe_customer
		begin
			params = {
				name: context.params[:name],
				email: context.params[:email],
				phone: context.params[:phone],
				metadata: {
					address: context.params[:address],
				}
			}
			context.stripe_customer = Stripe::Customer.create(params)
		rescue Stripe::InvalidRequestError => e
			message = "Failed to create stripe customer"
			message = message + ", Error: #{e&.error&.messahe}" if e.error&.message
			context.fail!(errors: [message])
		rescue => e
			message = "Failed to create stripe customer"
			message = message + ", Error: #{e&.error&.messahe}" if e.error&.message
			context.fail!(errors: [message])
		end
	end
end