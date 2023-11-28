class Invoice < ApplicationRecord
    belongs_to :matter_intake

    monetize :amount_cents

    has_many :invoice_attachments
    
    accepts_nested_attributes_for :invoice_attachments, reject_if: :all_blank, allow_destroy: true

    after_create_commit :send_invoice_email

    def self.ransackable_attributes(auth_object = nil)
        ["amount_cents", "amount_currency", "created_at", "date", "description", "hours", "id", "lawyer_name", "matter_intake_id", "rate", "rate_type", "status", "taxes", "updated_at"]
    end

    def send_invoice_email
        InvoiceMailer.send_invoice(self).deliver!
    end
end
