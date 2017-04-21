class InformationSecurityPolicy < ApplicationRecord
  has_many   :file_attachments, as: :attachable	
  belongs_to :form_value
end
