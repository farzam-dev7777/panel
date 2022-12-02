unless Rails.env.test?
  Stripe.api_key = Rails.application.secrets['stripe']['secret_key']
end