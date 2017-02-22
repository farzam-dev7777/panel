class FileAttachment < ApplicationRecord
  belongs_to :form_value

  mount_uploader :file, FileUploader
end
