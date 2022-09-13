class Invoice < ApplicationRecord
    belongs_to :matter_intake

    monetize :amount_cents

    has_many :invoice_attachments
    
    accepts_nested_attributes_for :invoice_attachments, reject_if: :all_blank, allow_destroy: true
end
