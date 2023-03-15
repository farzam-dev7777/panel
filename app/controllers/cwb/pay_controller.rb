class Cwb::PayController < ApplicationController

	layout "pay"

	def index
	end

	def stripe_publishable_key
		render json: {
			stripe_publishable_key: Rails.application.secrets[:stripe][:publishable_key]
		}
	end

	def find_and_create_stripe_customer
		response = FindOrCreateStripeCustomer.call(params: customer_params)

		if response.success?
			render json: {
				stripe_customer_id: response&.stripe_customer[:id],
			}
		else
			render json: {
				errors: response&.errors&.join(", ")
			}, status: 422
		end
	end

	def attach_payment_method_and_charge
		response = AttachPaymentMethodAndCharge.call(
			stripe_customer_id: params[:stripe_customer_id],
			payment_method_id: params[:payment_method_id],
		)

		if response.success?
			render json: :ok
		else
			render json: {
				errors: response&.errors&.join(", ")
			}, status: 422
		end
	end

	private
	def customer_params
		params.require(:customer).permit(:name, :email, :phone, :address)
	end

end