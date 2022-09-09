class Invoice < ApplicationRecord
    belongs_to :matter_intake

    monetize :amount_cents
end
