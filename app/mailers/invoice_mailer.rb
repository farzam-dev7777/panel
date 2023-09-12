class InvoiceMailer < ApplicationMailer
  default from: "SEAL Support <support@secureengage.com>"
  layout 'mailer'

  def send_invoice(invoice)
    if invoice.matter_intake&.line_of_business.email.present?
      email = invoice.matter_intake&.line_of_business.email
      @invoice = invoice
      @matter_intake = @invoice.matter_intake
      mail(to: email, subject: "New Invoice Created")
    end
  end
  
end
