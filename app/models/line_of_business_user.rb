class LineOfBusinessUser < ApplicationRecord
  belongs_to :user
  belongs_to :line_of_business
end
