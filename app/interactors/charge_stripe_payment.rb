class ChargeStripePayment
  include Interactor

	before :verify_execution
	#	{
	#		stripe_customer_id: String
	#		payment_method_id: String
	#	} 
	def call
		begin
			stripe_charge = Stripe::PaymentIntent.create({
				amount: (200 * 100)&.to_i, # In cents
				currency: 'cad',
				payment_method: context.payment_method_id,
				customer: context.stripe_customer_id,
				confirm: true,
				capture_method: 'automatic',
			})
		rescue => e
			message = "Something went wrong while charging customer"
			message = message + ", Error: #{e&.error&.message}" if e&.error && e&.error&.message
			context.fail!(errors: [message])
		end
	end

	def verify_execution
		if context.stripe_customer_id.blank?
			context.fail!(errors: ["Stripe customer reference must be specify"])
		end

		if context.payment_method_id.blank?
			context.fail!(errors: ["Payment method must be specify"])
		end
	end
end