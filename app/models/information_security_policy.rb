class InformationSecurityPolicy < ApplicationRecord
	include HasAttachedFiles
  has_many   :file_attachments, as: :attachable, dependent: :destroy
  belongs_to :form_value
end
