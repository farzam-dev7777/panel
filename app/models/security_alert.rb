class SecurityAlert < ApplicationRecord
  validates_presence_of :title, :description, :severity
end
