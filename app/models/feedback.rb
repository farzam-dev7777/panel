class Feedback < ApplicationRecord
  has_many :law_firms_feedbacks
  has_many :law_firms, :through => :law_firms_feedback
end

