class ReceiptDecorator < Draper::Decorator
  delegate_all
  decorates_association :message, with: MessageDecorator

end