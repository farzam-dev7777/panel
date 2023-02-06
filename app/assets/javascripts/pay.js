$(document).ready(function() {
  var stripe;
  var card;

  // Disable the button until we have Stripe set up on the page
  document.querySelector(".stripe_pay_btn").disabled = true;
  $.ajax({
    url: "pay/stripe_publishable_key",
    method: "GET",
    success: function(response) {
      if(response && response.stripe_publishable_key){
        initializeStripe(response.stripe_publishable_key);
      }
    },
    error: function(error) {
      if(error && error.responseJSON){
        toastr.error(error.responseJSON.errors, 'Opps!');
      } else {
        toastr.error('Error in getting stripe pub key', 'Opps!');
      }
    },
  });

  var initializeStripe = function(stripe_publishable_key) {
    stripe = Stripe(stripe_publishable_key);

    var elements = stripe.elements();
    var style = {
      base: {
        color: "#32325d",
        fontFamily: 'Arial, sans-serif',
        fontSmoothing: "antialiased",
        fontSize: "16px",
        "::placeholder": {
          color: "#32325d"
        },
        border: "1px solid #ccc"
      },
      invalid: {
        fontFamily: 'Arial, sans-serif',
        color: "#fa755a",
        iconColor: "#fa755a"
      }
    };

    card = elements.create("card", { hidePostalCode: true, style: style });
    // Stripe injects an iframe into the DOM
    card.mount("#card-element");

    card.on("change", function (event) {
      // Disable the Pay button if there are no card details in the Element
      document.querySelector(".stripe_pay_btn").disabled = event.empty;
      document.querySelector("#card-error").textContent = event.error ? event.error.message : "";
    });

    var form = document.getElementById("payment-form");
    form.addEventListener("submit", function(event) {
      event.preventDefault();
      handlePaymentFormSubmission();
    });
  }

  var handlePaymentFormSubmission = function() {
    var company_name = $('#company_name').val();
    var company_email = $('#company_email').val();
    var company_phone = $('#company_phone').val();
    var company_address = $('#company_address').val();
    var payment_authorization = $('#payment_authorization').is(":checked");

    if(!payment_authorization) {
      toastr.error("Please Authorize PANEL payment of $2800 if qualify under CRA.", 'Opps!');
      return;
    }
    
    var data = new FormData();
    data.append('customer[name]', company_name);
    data.append('customer[email]', company_email);
    data.append('customer[phone]', company_phone);
    data.append('customer[address]', company_address);
    
    if (company_name != "" && company_email != "" && company_phone != "" && company_address != "") {
      loading(true);
      $.ajax({
        url: "pay/find_and_create_stripe_customer",
        method: "POST",
        data: data,
        processData: false,
        contentType: false,
        success: function(response) {
          // attach Payment Method & charge
          if(response){
            attachPaymentMethodAndCharge(response.stripe_customer_id);
          }
        },
        error: function(error) {
          loading(false);
          if(error && error.responseJSON){
            toastr.error(error.responseJSON.errors, 'Opps!');
          } else {
            toastr.error('Error in find/create stripe customer', 'Opps!');
          }
        }
      });
      
    }
  }

  var attachPaymentMethodAndCharge = async function(stripeCustomerId) {
    if (stripeCustomerId) {
      stripe.createPaymentMethod({
        type: 'card',
        card: card,
      })
      .then((response) => {
        if (response.error) {
          loading(false);
          toastr.error('Something went wrong while creating payment method', 'Opps!');
        }
        if (response && response.paymentMethod) {
          var data = new FormData();
          data.append('stripe_customer_id', stripeCustomerId);
          data.append('payment_method_id', response.paymentMethod.id);
          $.ajax({
            url: "pay/attach_payment_method_and_charge",
            method: "POST",
            data: data,
            processData: false,
            contentType: false,
            success: function(response) {
              loading(false);
              $('#company_name').val('');
              $('#company_email').val('');
              $('#company_phone').val('');
              $('#company_address').val('');
              toastr.success('You are charge $200 successfully', 'Success');
            },
            error: function(error) {
              loading(false);
              if(error && error.responseJSON){
                toastr.error(error.responseJSON.errors, 'Oops!');
              } else {
                toastr.error('Something went wrong while charging', 'Oops!');
              }
            }
          })
        }
      })
    } else {
      loading(false);
      // TODO: show some error
    }

  }

  // Show a spinner on payment submission
  var loading = function(isLoading) {
    if (isLoading) {
      // Disable the button and show a spinner
      document.querySelector(".stripe_pay_btn").disabled = true;
      document.querySelector("#spinner").classList.remove("hidden");
      document.querySelector("#button-text").classList.add("hidden");
    } else {
      document.querySelector(".stripe_pay_btn").disabled = false;
      document.querySelector("#spinner").classList.add("hidden");
      document.querySelector("#button-text").classList.remove("hidden");
    }
  };
    

});