class Invoice < ApplicationRecord
    belongs_to :matter_intake

    monetize :amount_cents

    has_many :invoice_attachments
    
    accepts_nested_attributes_for :invoice_attachments, reject_if: :all_blank, allow_destroy: true

    after_create_commit :send_invoice_email


    def send_invoice_email
        InvoiceMailer.send_invoice(self).deliver!
    end
end
