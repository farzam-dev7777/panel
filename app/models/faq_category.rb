class FaqCategory < ApplicationRecord
  has_many :frequently_asked_questions, foreign_key: :faq_category_id
end
