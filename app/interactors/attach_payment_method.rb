class AttachPaymentMethod
  include Interactor

	before :verify_execution
	#	{
	#		stripe_customer_id: String
	#		payment_method_id: String
	#	}
	def call
		begin
			attach_payment_method = Stripe::PaymentMethod.attach(
				context.payment_method_id,
				{customer: context.stripe_customer_id},
			)
		rescue => e
			message = "Something went wrong while attaching payment method with customer"
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

		verify_stripe_customer
		verify_payment_method
	end
	
	def verify_stripe_customer
		begin
			context.stripe_customer = Stripe::Customer.retrieve(context.stripe_customer_id)

			if context.stripe_customer.deleted?
				# Customer deleted from stripe
				context.fail!(errors: ["Customer seems deleted from stripe"])
			end
		rescue Stripe::InvalidRequestError => e
			if e&.http_status === 404
				# Customer not found
				context.fail!(errors: ["Customer not found on stripe"])
			end
		rescue => e
			message = "Something went wrong while verifing customer"
			message = message + ", Error: #{e&.error&.message}" if e&.error && e&.error&.message
			context.fail!(errors: [message])
		end
	end

	def verify_payment_method
		begin
			payment_method = Stripe::PaymentMethod.retrieve(context.payment_method_id)

			if payment_method[:id].blank?
				context.fail!(errors: ["Payment method not found/ yet not created on stripe"])
			end
		rescue Stripe::InvalidRequestError => e
			if e&.http_status === 404
				# Payment Method not found
				context.fail!(errors: ["Payment method not found on stripe"])
			end
		rescue => e
			message = "Something went wrong while verifing payment method"
			message = message + ", Error: #{e&.error&.message}" if e&.error && e&.error&.message
			context.fail!(errors: [message])
		end
	end

end