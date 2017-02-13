class ConversationDecorator < Draper::Decorator
  delegate_all
  decorates_association :receipts, with: ReceiptDecorator

  def name
    "Jasdeep"
  end

end