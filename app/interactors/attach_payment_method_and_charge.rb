class AttachPaymentMethodAndCharge
	include Interactor::Organizer

	organize AttachPaymentMethod, ChargeStripePayment
end