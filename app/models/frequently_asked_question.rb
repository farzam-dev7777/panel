class FrequentlyAskedQuestion < ApplicationRecord
  validates_presence_of :question, :answer
  belongs_to :faq_category

end
